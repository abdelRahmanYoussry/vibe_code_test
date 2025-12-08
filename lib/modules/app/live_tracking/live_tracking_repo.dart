import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test_vibe/core/app/app_bloc.dart';
import 'package:test_vibe/core/utils/debouncer.dart';
import 'package:test_vibe/core/utils/remote/api_app_config.dart';
import 'package:test_vibe/modules/app/orders/repo/orders_repo.dart';
import 'package:test_vibe/modules/auth/repo/auth_repo.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LiveTrackingRepo {
  final OrdersRepo ordersRepo;
  final AuthRepo authRepo;
  final FirebaseFirestore firestore;

  // Add this property to control auto-assign
  bool autoAssignBranchEnabled = true;

  static const _debounce = 1000;

  LiveTrackingRepo({
    required this.ordersRepo,
    required this.authRepo,
    required this.firestore,
  }) {
    if (defaultTargetPlatform == TargetPlatform.android) {
      _locationSettings = AndroidSettings(
        accuracy: LocationAccuracy.best,
        distanceFilter: 100,
        forceLocationManager: false,
        intervalDuration: const Duration(seconds: _debounce),
        // intervalDuration: const Duration(milliseconds: _debounce),
        //(Optional) Set foreground notification config to keep the app alive
        //when going to the background
        foregroundNotificationConfig: _isTracking
            ? const ForegroundNotificationConfig(
                notificationText: "Claro will continue to receive your location even when you aren't using it",
                notificationTitle: "Running in Background",
                enableWakeLock: true,
              )
            : null,
      );
    } else {
      _locationSettings = AppleSettings(
        accuracy: LocationAccuracy.best,
        activityType: ActivityType.fitness,
        // distanceFilter: 100,
        pauseLocationUpdatesAutomatically: true,
        // Only set to true if our app will be started up in the background.
        showBackgroundLocationIndicator: true,
      );
    }
  }

  final Debouncer _locationDebouncer = Debouncer();
  late final LocationSettings _locationSettings;

  StreamSubscription<Position>? _streamSubscription;
  bool _isTracking = false;
  Timer? _locationTimer;
  StreamSubscription<Position>? _positionStreamSubscription;

  /// Callback to notify UI about branch change
  void Function(BranchChangeInfo)? onBranchChanged;

  Future<void> checkOrdersAndDetermineTracking() async {
    final f = await ordersRepo.getOrders('1', 'active');
    f.fold(
      (l) {},
      (r) {
        debugPrint('LiveTrackingRepo.checkOrdersAndDetermineTracking ${r.activeOrdersCount}');
        if (r.activeOrdersCount > 0) {
          startTracking();
        } else {
          stopTracking();
        }
      },
    );
  }

  /// returns an error message if the permission is not granted
  /// returns null if permission is granted
  Future<String?> checkPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return 'Location services are disabled.';
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return 'Location permissions are denied';
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return 'Location permissions are permanently denied, we cannot request permissions.';
    }

    return null;
  }

  Future<void> sendLocationToServers(Position position) async {
    // _locationDebouncer.run(
    //   () {
    final id = authRepo.user?.id;
    debugPrint('LiveTrackingRepo.sendLocationToServers $id ${position.latitude} ${position.longitude}');
    if (id != null) {
      firestore.collection('order_locations').doc(id).set({
        'lat': position.latitude,
        'lng': position.longitude,
      });
    }
    // },
    // _debounce,
    // );
  }

  Future<void> startTracking() async {
    if (_isTracking) return;
    final error = await checkPermission();
    if (error == null) {
      _isTracking = true;
      final position = await Geolocator.getCurrentPosition(locationSettings: _locationSettings);
      sendLocationToServers(position);
      _streamSubscription =
          Geolocator.getPositionStream(locationSettings: _locationSettings).listen(sendLocationToServers);
    }
  }

  // Future<void> stopTracking() async {
  //   debugPrint('LiveTrackingRepo.stopTracking');
  //   _isTracking = false;
  //   await _streamSubscription?.cancel();
  //   _streamSubscription = null;
  // }
  Future<void> stopTracking() async {
    debugPrint('LiveTrackingRepo.stopTracking');
    _isTracking = false;

    // Cancel the stream subscription
    await _streamSubscription?.cancel();
    _streamSubscription = null;

    // Additional cleanup for Android
    if (defaultTargetPlatform == TargetPlatform.android) {
      try {
        // Force stop location services
        await Geolocator.getCurrentPosition(
          locationSettings: AndroidSettings(
            accuracy: LocationAccuracy.lowest,
            forceLocationManager: false,
            foregroundNotificationConfig: null,
          ),
        ).timeout(Duration(milliseconds: 100));
      } catch (e) {
        // Ignore timeout/errors as we just want to reset the service
        debugPrint('Location service reset completed');
      }
    }
  }

  dispose() {
    _streamSubscription?.cancel();
    _locationTimer?.cancel();
    _positionStreamSubscription?.cancel();
    _locationTimer = null;
    _positionStreamSubscription = null;
    _streamSubscription = null;
  }

  Future<void> startLocationTracking() async {
    try {
      final hasPermission = await _checkLocationPermission();
      if (!hasPermission) return;
      if(!autoAssignBranchEnabled) {
        debugPrint('Auto-assign branch is disabled. Skipping location tracking.');
        return;
      }

      await _sendCurrentLocationToFirebase();
      _startPeriodicLocationUpdates();
    } catch (e) {
      debugPrint('Error starting location tracking: $e');
    }
  }

  Future<void> stopLocationTracking() async {
    _locationTimer?.cancel();
    _locationTimer = null;
    debugPrint('Location tracking stopped.');
    _positionStreamSubscription?.cancel();
    _positionStreamSubscription = null;
  }

  // Check and request location permissions
  Future<bool> _checkLocationPermission() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      debugPrint('Location services are disabled.');
      return false;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        debugPrint('Location permissions are denied');
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      debugPrint('Location permissions are permanently denied');
      return false;
    }

    return true;
  }

  // Get current location and send to Firebase
  Future<void> _sendCurrentLocationToFirebase() async {
    try {
      final user = authRepo.user;
      if (user?.id == null) return;

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      await _saveLocationToFirebase(
        userId: user!.id.toString(),
        latitude: position.latitude,
        longitude: position.longitude,
      );
    } catch (e) {
      debugPrint('Error getting location: $e');
    }
  }

  // Save location data to Firebase
  Future<void> _saveLocationToFirebase({
    required String userId,
    required double latitude,
    required double longitude,
  }) async {
    try {
      await FirebaseFirestore.instance.collection('userLocation').doc(userId).set({
        'latitude': latitude,
        'longitude': longitude,
        'timestamp': FieldValue.serverTimestamp(),
        'lastUpdated': DateTime.now().toIso8601String(),
      }, SetOptions(merge: true));

      debugPrint('Location saved to Firebase: $latitude, $longitude');

      // After saving location, call auto-assign branch API only if enabled
      if (autoAssignBranchEnabled) {
        await _autoAssignNearestBranch(latitude, longitude);
      }
    } catch (e) {
      debugPrint('Error saving location to Firebase: $e');
    }
  }

  Future<void> _autoAssignNearestBranch(double latitude, double longitude) async {
    try {
      final token = authRepo.token;
      if (token == null) return;
      final apiHelper = authRepo.apiHelper;
      final response = await apiHelper.postData(
        AppConfig.autoAssignBranch(),
        token: token,
        typeJSON: true,
        data: {
          'latitude': latitude,
          'longitude': longitude,
        },
      );
      final json = jsonDecode(response);
      if (json['error'] == false && json['data'] != null) {
        final branchData = json['data'];
        final user = AppBloc().state.user;
        // Compare with current branch
        if (user != null && (user.store_locator?.id != branchData['store_id'].toString())) {
          // Branch changed
          if (onBranchChanged != null) {
            onBranchChanged!(BranchChangeInfo(
              storeName: branchData['store_name'],
              storeAddress: branchData['store_address'],
              storeId: branchData['store_id'].toString(),
            ));
          }
        }
      }
    } catch (e) {
      debugPrint('Error auto-assigning branch: $e');
    }
  }

  void _startPeriodicLocationUpdates() {
    _locationTimer?.cancel();
    _locationTimer = Timer.periodic(Duration(seconds: 30), (timer) {
      _sendCurrentLocationToFirebase();
    });
  }
}

class BranchChangeInfo {
  final String storeName;
  final String storeAddress;
  final String storeId;
  BranchChangeInfo({required this.storeName, required this.storeAddress, required this.storeId});
}
