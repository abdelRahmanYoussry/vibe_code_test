import 'dart:math';

import 'package:test_vibe/core/assets/gen/assets.gen.dart';
import 'package:test_vibe/core/utils/logger.dart';
import 'package:test_vibe/core/utils/math_utils.dart';
import 'package:test_vibe/core/utils/repeater.dart';
import 'package:test_vibe/core/utils/safe_utils.dart';
import 'package:test_vibe/modules/app/spinner/widgets/spinner/spinner_theme.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import '../../../spinners/models/spinner_model_new.dart';
import '../../../spinners/models/spinner_reward_model.dart';
import 'spinner_painter.dart';

class Spinner extends StatefulWidget {
  const Spinner({
    super.key,
    required this.controller,
  });

  final SpinnerController controller;

  @override
  State<Spinner> createState() => _SpinnerState();
}

class _SpinnerState extends State<Spinner> with TickerProviderStateMixin {
  late final SpinnerController _controller;

  late final AnimationController _animationController;
  late final Tween<double> _animationTween;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller;
    _animationController = AnimationController(vsync: this, duration: SpinnerController._indefinitelyDuration);
    _animationController.repeat();
    _animationTween = Tween<double>(begin: degToRad(0), end: degToRad(360));
    _animation = _animationTween.animate(_animationController);

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   if (mounted) {
    //     setState(() {
    //       _controller._setup(context);
    //     });
    //   }
    // });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Try to set up again when dependencies change (like Theme)
    _controller._setup(context);
  }

  @override
  Widget build(BuildContext context) {
    final myTheme = SpinnerTheme.of(context);
    return AspectRatio(
      aspectRatio: 1,
      child: SizedBox(
        width: double.infinity,
        child: Stack(
          alignment: Alignment.center,
          fit: StackFit.expand,
          children: [
            if (_controller._items.isNotEmpty) // Only show when we have items
              ValueListenableBuilder(
                valueListenable: _controller,
                builder: (context, rotation, child) => Stack(
                  alignment: Alignment.center,
                  fit: StackFit.expand,
                  children: [
                    //indefinitely spin
                    TweenAnimationBuilder(
                      duration: SpinnerController._fadeTransitionDuration,
                      curve: Curves.linear,
                      tween: Tween<double>(end: rotation == -1 ? 1 : 0),
                      builder: (context, opacity, child) => Opacity(
                        opacity: opacity.clamp(0, 1),
                        child: child,
                      ),
                      child: AnimatedBuilder(
                        animation: _animation,
                        builder: (context, child) => Transform.rotate(
                          angle: _animation.value,
                          child: child,
                        ),
                        child: child,
                      ),
                    ),
                    //normal spin
                    TweenAnimationBuilder(
                      duration: SpinnerController._fadeTransitionDuration,
                      curve: Curves.linear,
                      tween: Tween<double>(end: rotation == -1 ? 0 : 1),
                      builder: (context, opacity, child) => Opacity(
                        opacity: opacity.clamp(0, 1),
                        child: child,
                      ),
                      child: TweenAnimationBuilder(
                        duration: _controller._duration,
                        curve: _controller._curve,
                        tween: Tween(end: rotation),
                        builder: (context, tweenRotation, child) => Transform.rotate(
                          angle: degToRad(tweenRotation),
                          child: child,
                        ),
                        child: child,
                      ),
                    ),
                  ],
                ),
                child: CustomPaint(
                  painter: SpinnerPainter(
                    outerBorderColor: myTheme.outerBorderColor,
                    outerBorderCirclesColor: myTheme.outerBorderCirclesColor,
                    innerBorderColor: myTheme.innerBorderColor,
                    innerBorderCircleColor: myTheme.innerBorderCircleColor,
                    items: _controller._items,
                  ),
                ),
              ),
            CustomPaint(
              painter: SpinnerArrowPainter(
                arrowInnerBorderColor: myTheme.arrowInnerBorderColor,
                arrowOuterBorderColor: myTheme.arrowOuterBorderColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SpinnerController extends ValueNotifier<double> {
  late final Random _random;
  late final AudioPlayer _audioPlayer;
  final int spinnerId;

  /// number of rotations to add to the spin
  static const int _headStartCount = 1;

  /// duration of all the spins when calling the [spin] function
  static const Duration _spinDuration = Duration(milliseconds: 5500);

  /// duration of the stopping animation when calling the [stop] function
  static const Duration _stoppingDuration = Duration(milliseconds: 1500);

  /// duration of the rewind animation when calling the [respin] function
  static const Duration _rewindDuration = Duration(milliseconds: 250);

  /// duration of a single spin in indefinitely mode when [value] is equal to -1
  static const Duration _indefinitelyDuration = Duration(milliseconds: 500);

  /// duration of the fade transition when switching between indefinitely spinning animation and stopping animation
  static const Duration _fadeTransitionDuration = Duration(milliseconds: 25);

  bool _isInitialized = false;
  Duration _selectedDuration = _spinDuration;

  Duration get _duration => _selectedDuration;

  static const Curve _spinCurve = CosineEaseOutCurve();
  static const Curve _rewindCurve = Curves.easeInOut;

  Curve _selectedCurve = _spinCurve;

  Curve get _curve => _selectedCurve;

  final List<SpinnerItemModel> _models;
  final List<SpinnerItem> _items = [];

  Repeater<Color>? _repeater;
  SpinnerItemModel? _selectedItem;

  bool hasSpinned = false;

  SpinnerItemModel? get selectedItem => _selectedItem;

  SpinnerController({
    required List<SpinnerItemModel> models,
    required this.spinnerId,
  })  : _models = models,
        super(0) {
    _random = Random();
    _audioPlayer = AudioPlayer();
    _audioPlayer.setAsset(Assets.sounds.jewelryRingSpin2x);
  }

  bool get isInitialized => _isInitialized;

  /// first setup method without considering display percentages
  _setup(BuildContext context) {
    if (_isInitialized) return; // Prevent multiple setup calls

    final myTheme = SpinnerTheme.of(context);
    _repeater = Repeater(
      [...myTheme.colors],
      _models.length,
    );

    _items.clear(); // Clear any existing items

    for (final item in _models) {
      if (_repeater != null) {
        final color = _repeater!.get();
        _items.add(
          SpinnerItem(
            title: TextSpan(
              text: item.text.toString(),
              style: myTheme.labelTextStyle.copyWith(
                color: ThemeData.estimateBrightnessForColor(color) == Brightness.dark ? myTheme.textColorDark : myTheme.textColorLight,
              ),
            ),
            color: color,
          ),
        );
      }
    }

    _isInitialized = true;

    logger('Spinner Setup', {
      'Total Models': '${_models.length}',
      'Total Segments': '${_items.length}',
      'Items in Wheel': '${_items.length}',
    });
  }

//   _setup(BuildContext context) {
//     final myTheme = SpinnerTheme.of(context);
//     _repeater = Repeater(
//       [...myTheme.colors],
//       _models.length,
//     );
//     for (final item in _models) {
//       if (_repeater != null) {
//         final color = _repeater!.get();
//         _items.add(
//           SpinnerItem(
//             title: TextSpan(
//               text: item.text.toString(),
//               style: myTheme.labelTextStyle.copyWith(
//                 color: ThemeData.estimateBrightnessForColor(color) == Brightness.dark ? myTheme.textColorDark : myTheme.textColorLight,
//               ),
//             ),
//             color: color,
//           ),
//         );
//       }
//     }
//       logger('Spinner Setup', {
//         'Total Models': '${_models.length}',
//         'Total Segments': '${_items.length}',
//         'Items in Wheel': '${_items.length}',
//       });
//   }
  Future<SpinnerItemModel?> spin({SpinnerRewardResult? preloadedResult}) async {
    if (_models.isEmpty) return _selectedItem;
    if (hasSpinned) return _selectedItem;

    hasSpinned = true;
    _selectedDuration = _spinDuration;
    _selectedCurve = _spinCurve;

    _audioPlayer.seek(Duration.zero);
    _audioPlayer.play();

    // Use the preloaded API result instead of calling the API
    final apiResult = preloadedResult;

    // Find the corresponding model in the wheel items
    SpinnerItemModel? matchedItem;
    if (apiResult != null) {
      matchedItem = _models.firstWhere(
        (model) => model.id == apiResult.rewardId || model.text == apiResult.rewardName,
        orElse: () => _models.first,
      );
    }

    // Find the index of this item in our wheel
    int targetIndex = -1;
    if (matchedItem != null) {
      for (int i = 0; i < _models.length; i++) {
        if (_models[i].id == matchedItem.id || _models[i].text == matchedItem.text) {
          targetIndex = i;
          break;
        }
      }
    }

    // If we couldn't find the item, use a random index
    if (targetIndex == -1) {
      targetIndex = _random.nextInt(_models.length);
    }

    // Calculate angle for this specific segment
    final segmentSize = 360 / _models.length;
    // Calculate the middle of the segment for smoother visual landing
    final targetAngle = (targetIndex * segmentSize) + (segmentSize / 2);
    // Adjust to make sure arrow points to correct segment
    final adjustedAngle = 360 - targetAngle;
    // Add multiple rotations for visual effect
    final headStart = 360 * _headStartCount;

    // Animate to the specific angle
    await Future.delayed(Duration(milliseconds: 250));
    value = adjustedAngle + headStart;

    // Set the selected item based on API result
    if (apiResult != null) {
      _selectedItem = SpinnerItemModel(
        id: apiResult.rewardId!,
        text: apiResult.rewardName ?? "",
        percent: matchedItem?.percent ?? 1,
      );
    } else {
      _selectedItem = _models.safeElementAt(targetIndex);
    }

    logger('SpinWheel', {
      'angle': '${adjustedAngle.toStringAsFixed(2)}°',
      'target segment': '$targetIndex',
      'API result': apiResult != null ? '${apiResult.rewardName}' : 'Failed',
      'item': '${_selectedItem?.text}',
    });

    await Future.delayed(_selectedDuration);
    return _selectedItem;
  }

  Future<SpinnerItemModel?> stop({SpinnerRewardResult? preloadedResult}) async {
    if (_models.isEmpty) return _selectedItem;
    if (!hasSpinned) return _selectedItem;

    hasSpinned = false;
    _selectedDuration = _stoppingDuration;
    _selectedCurve = _spinCurve;

    // _audioPlayer.seek(Duration.zero);
    // _audioPlayer.play();

    // Use the preloaded API result instead of calling the API
    final apiResult = preloadedResult;

    // Find the corresponding model in the wheel items
    SpinnerItemModel? matchedItem;
    if (apiResult != null) {
      matchedItem = _models.firstWhere(
        (model) => model.id == apiResult.rewardId || model.text == apiResult.rewardName,
        orElse: () => _models.first,
      );
    }

    // Find the index of this item in our wheel
    int targetIndex = -1;
    if (matchedItem != null) {
      for (int i = 0; i < _models.length; i++) {
        if (_models[i].id == matchedItem.id || _models[i].text == matchedItem.text) {
          targetIndex = i;
          break;
        }
      }
    }

    // If we couldn't find the item, use a random index
    if (targetIndex == -1) {
      targetIndex = _random.nextInt(_models.length);
    }

    // Calculate angle for this specific segment
    final segmentSize = 360 / _models.length;
    // Calculate the middle of the segment for smoother visual landing
    final targetAngle = (targetIndex * segmentSize) + (segmentSize / 2);
    // Adjust to make sure arrow points to correct segment
    final adjustedAngle = 360 - targetAngle;
    // Add multiple rotations for visual effect
    final headStart = 360 * _headStartCount;

    // Animate to the specific angle
    await Future.delayed(Duration(milliseconds: 250));
    value = adjustedAngle + headStart;

    // Set the selected item based on API result
    if (apiResult != null) {
      _selectedItem = SpinnerItemModel(
        id: apiResult.rewardId!,
        text: apiResult.rewardName ?? "",
        percent: matchedItem?.percent ?? 1,
      );
    } else {
      _selectedItem = _models.safeElementAt(targetIndex);
    }

    logger('SpinWheel', {
      'angle': '${adjustedAngle.toStringAsFixed(2)}°',
      'target segment': '$targetIndex',
      'API result': apiResult != null ? '${apiResult.rewardName}' : 'Failed',
      'item': '${_selectedItem?.text}',
    });

    await Future.delayed(_selectedDuration);
    return _selectedItem;
  }

  Future<void> spinIndefinitely() async {
    if (hasSpinned) return;
    hasSpinned = true;
    value = -1;
  }

  // final spin method with call spin api
  // Future<SpinnerItemModel?> spin() async {
  //   if (_models.isEmpty) return _selectedItem;
  //   if (hasSpinned) return _selectedItem;
  //
  //   hasSpinned = true;
  //   _selectedDuration = _spinDuration;
  //   _selectedCurve = _spinCurve;
  //
  //   _audioPlayer.seek(Duration.zero);
  //   _audioPlayer.play();
  //
  //   // Generate a random angle for animation
  //   final randomAngle = _random.nextDouble() * 360;
  //   final headStart = 360 * 100;
  //   await Future.delayed(Duration(milliseconds: 250));
  //   value = randomAngle + headStart;
  //
  //   // Call the API to get the actual reward
  //   final apiResult = await bloc.spinTheWheel(spinnerId);
  //
  //   // Calculate visual winner for display purposes
  //   final segment = 360 / _models.length;
  //   final adjustedAngle = (360 - randomAngle) % 360;
  //   final selectedIndex = (adjustedAngle ~/ segment) % _models.length;
  //
  //   // If we got a result from API, create a SpinnerItemModel from it
  //   if (apiResult != null && apiResult.rewardId != null) {
  //     _selectedItem = SpinnerItemModel(
  //       id: apiResult.rewardId!,
  //       text: apiResult.rewardName ?? "",
  //       percent: 1, // Default percent for display
  //     );
  //   } else {
  //     // Fallback to random selection if API fails
  //     _selectedItem = _models.safeElementAt(selectedIndex);
  //   }
  //
  //   logger('SpinWheel', {
  //     'angle': '${randomAngle.toStringAsFixed(2)}°',
  //     'API result': apiResult != null ? '${apiResult.rewardName}' : 'Failed',
  //     'item': '${_selectedItem?.text}',
  //   });
  //
  //   await Future.delayed(_selectedDuration);
  //   return _selectedItem;
  // }
  Future<SpinnerItemModel?> respin() async {
    hasSpinned = false;
    _selectedDuration = _rewindDuration;
    _selectedCurve = _rewindCurve;
    value = 0;
    await Future.delayed(_selectedDuration);
    await Future.delayed(Duration(milliseconds: 500));
    return await spin();
  }

  @override
  void dispose() {
    _audioPlayer.stop();
    _audioPlayer.dispose();
    super.dispose();
  }
}
// // Helper class to keep track of item data during shuffling
// class _SpinnerItemData {
//   final String text;
//   final SpinnerItemModel model;
//
//   _SpinnerItemData({required this.text, required this.model});
// }

class SmoothDecelerateCurve extends Curve {
  const SmoothDecelerateCurve();

  @override
  double transformInternal(double t) {
    // Quintic ease out: slower, smoother deceleration
    return 1 - pow(1 - t, 5).toDouble();
  }
}

class CosineEaseOutCurve extends Curve {
  const CosineEaseOutCurve();

  @override
  double transformInternal(double t) {
    // Smooth like a ball bearing
    return sin(t * (pi / 2));
  }
}

class ExponentialEaseOutCurve extends Curve {
  const ExponentialEaseOutCurve();

  @override
  double transformInternal(double t) {
    return 1 - pow(2, -10 * t).toDouble();
  }
}
