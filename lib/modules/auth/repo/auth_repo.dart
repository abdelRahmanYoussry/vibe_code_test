import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../../core/app/app_bloc.dart';
import '../../../core/cache/cache_helper.dart';
import '../../../core/di/di.dart';
import '../../../core/models/global_model/global_response_model.dart';
import '../../../core/models/pickup_image_model.dart';
import '../../../core/models/user_model.dart';
import '../../../core/parameters/register_parameters.dart';
import '../../../core/repos/lang_repo.dart';
import '../../../core/theme/constants/app_strings.dart';
import '../../../core/utils/cart_count/cart_count_bloc.dart';
import '../../../core/utils/data_utils.dart';
import '../../../core/utils/device_info/device_info.dart';
import '../../../core/utils/notification_count/notifications_count_bloc.dart';
import '../../../core/utils/notifications/setup_notifications.dart';
import '../../../core/utils/states/generic_state.dart';
import '../../../core/utils/pick_image_utils.dart';
import '../../../core/utils/remote/api_app_config.dart';
import '../../../core/utils/remote/api_helper.dart';
import '../../../core/utils/remote/dio_helper.dart';

class AuthRepo {
  final ApiHelper apiHelper;
  final DioHelper dioHelper;
  final LangRepo langRepo;
  final CacheHelper cacheHelper;
  final SetupFCM setupFCM;
  UserData? user;
  String? token;
  File? profileImageFile;
  var picker = ImagePicker();

  AuthRepo(
    this.apiHelper,
    this.langRepo,
    this.cacheHelper,
    this.dioHelper,
    this.setupFCM,
  );

  Future<Either<String, GlobalResponseModel>> logout() async {
    try {
      var response = await apiHelper.postData(
        AppConfig.logout(),
        token: token,
        lang: langRepo.lang,
        typeJSON: true,
      );
      GlobalResponseModel globalResponseModel = GlobalResponseModel.fromJson(jsonDecode(response));
      if (validString(globalResponseModel.showError())) {
        return Left(globalResponseModel.showError());
      }
      _removeUser();
      return Right(globalResponseModel);
    } catch (e, s) {
      log(e.toString());
      log(s.toString());
      return Left(getServerError());
    }
  }

  Future<Either<String, GlobalResponseModel>> deleteAccount() async {
    try {
      var response = await apiHelper.deleteData(
        AppConfig.deleteAccount(),
        token: token,
        lang: langRepo.lang,
        typeJSON: true,
      );
      final data = jsonDecode(response);
      if (data.isEmpty) {
        return Left(getServerError());
      }
      GlobalResponseModel globalResponseModel = GlobalResponseModel.fromJson(data);
      if (validString(globalResponseModel.showError())) {
        return Left(globalResponseModel.showError());
      }
      if (globalResponseModel.error == true) {
        return Left(globalResponseModel.message ?? getServerError());
      }
      _removeUser();
      return Right(globalResponseModel);
    } catch (e, s) {
      log(e.toString());
      log(s.toString());
      return Left(getServerError());
    }
  }

  Future<Either<Failure, UserData>> getProfile({bool getNewData = false}) async {
    try {
      if (user == null || getNewData) {
        final response = await apiHelper.getData(
          AppConfig.getProfile(),
          lang: langRepo.lang,
          typeJSON: true,
          token: token,
        );
        GlobalResponseModel globalResponseModel = GlobalResponseModel.fromJson(jsonDecode(response));

        if (validString(
          globalResponseModel.showError(),
        )) {
          return Left(
            globalResponseModel.showError(),
          );
        }
        final data = jsonDecode(response);
        await _saveUser(UserData.fromJson(data?['data'] ?? {}, token));
      }

      return Right(user!);
    } catch (e) {
      log(e.toString());
      return Left(ServerFailure(message: getServerError()));
    }
  }

  Future<Either<String, UserModel>> updateProfile({required String phone, required String name}) async {
    try {
      final response = await apiHelper.postData(
        AppConfig.updateProfile(),
        lang: langRepo.lang,
        typeJSON: true,
        token: token,
        data: {
          'name': name,
          'phone': phone,
        },
      );
      if (response.isEmpty) {
        return Left(getServerError());
      }
      final data = jsonDecode(response);
      GlobalResponseModel globalResponseModel = GlobalResponseModel.fromJson(data);
      if (validString(globalResponseModel.showError())) {
        return Left(globalResponseModel.showError());
      }
      UserModel userModel = UserModel.fromJson(data);

      await _saveUser(UserData.fromJson(data?['data'] ?? {}, token));

      return Right(userModel);
    } catch (e) {
      log(e.toString());
      return Left(getServerError());
    }
  }

  Future<Either<String, GlobalResponseModel>> loginWithPhone({required String phone}) async {
    try {
      final devToken = await setupFCM.getFcmToken();
      var response = await apiHelper.postData(
        AppConfig.login(),
        lang: langRepo.lang,
        data: {
          'phone': phone,
          'device_token': devToken,
        },
        typeJSON: true,
      );

      final data = jsonDecode(response);
      GlobalResponseModel globalResponseModel = GlobalResponseModel.fromJson(data);
      if (validString(globalResponseModel.showError())) {
        return Left(globalResponseModel.showError());
      }
      return Right(globalResponseModel);
    } catch (e, s) {
      log('$e e.strng');
      log(s.toString());
      return Left(getServerError());
    }
  }

  Future<Either<String, UserModel>> verifyLoginCode({required String phone, required String code}) async {
    try {
      var response = await apiHelper.postData(
        AppConfig.verifyCode(),
        lang: langRepo.lang,
        data: {
          'phone': phone,
          'code': code,
        },
        typeJSON: true,
      );
      final data = jsonDecode(response);
      GlobalResponseModel globalResponseModel = GlobalResponseModel.fromJson(data);
      if (validString(globalResponseModel.showError()) || data['data'] == null) {
        // Return the actual error message from the response or a default one
        return Left(globalResponseModel.message ?? "Verification code is incorrect or expired");
      }

      await _saveUser(UserData.fromJson(data?['data'] ?? {}, data['data']['access_token']));
      UserModel userModel = UserModel.fromJson(data);
      return Right(userModel);
    } catch (e, s) {
      log(e.toString());
      log(s.toString());
      return Left(getServerError());
    }
  }



  Future<Either<String, UserModel>> verifyRegisterLoginCode({required String phone, required String code}) async {
    try {
      var response = await apiHelper.postData(
        AppConfig.verifyRegisterOtp(),
        lang: langRepo.lang,
        data: {
          'phone': phone,
          'code': code,
        },
        typeJSON: true,
      );
      final data = jsonDecode(response);
      GlobalResponseModel globalResponseModel = GlobalResponseModel.fromJson(data);
      if (validString(globalResponseModel.showError()) || data['data'] == null) {
        // Return the actual error message from the response or a default one
        return Left(globalResponseModel.message ?? "Verification code is incorrect or expired");
      }

      await _saveUser(UserData.fromJson(data?['data'] ?? {}, data['data']['access_token']));
      UserModel userModel = UserModel.fromJson(data);
      return Right(userModel);
    } catch (e, s) {
      log(e.toString());
      log(s.toString());
      return Left(getServerError());
    }
  }

  Future<Either<String, GlobalResponseModel>> updateUserWithDataBase({required ProfileParameters parameters}) async {
    try {
      final Map<String, dynamic> data = parameters.toMap();
      debugPrint("data $data");

      if (parameters.image != null) {
        data['avatar'] = await prepareImageForUpload(parameters.image!);
      }

      if (parameters.phone != null) {
        if (parameters.phone!.startsWith('0')) {
          data["phone"] = parameters.phone!.substring(1);
        }
      }

      // if (parameters.name != null) {
      //   data["name"] = parameters.name;
      // }

      if (parameters.email != null) {
        data["email"] = parameters.email;
      }

      if (parameters.stateId != null) {
        data["city_id"] = parameters.stateId;
      }

      if (parameters.countryId != null) {
        data["country_id"] = parameters.countryId;
      }

      var response = await dioHelper.postMultiPart(
        AppConfig.updateUserInfo(),
        token: token!, // token,
        lang: langRepo.lang ?? "ar",
        data: FormData.fromMap(data),
      );
      GlobalResponseModel globalResponseModel = GlobalResponseModel.fromJson(response);
      if (validString(globalResponseModel.showError())) {
        return Left(globalResponseModel.showError());
      }

      return Right(globalResponseModel);
    } catch (e, s) {
      log(e.toString());
      log(s.toString());
      return Left(getServerError());
    }
  }

  Future<Either<String, UserModel>> registerWithDataBase({required ProfileParameters parameters}) async {
    try {
      final devToken = await setupFCM.getFcmToken();
      final Map<String, dynamic> dataMap = parameters.toMap();
      if (parameters.image != null) {
        dataMap['avatar'] = await prepareImageForUpload(parameters.image!);
      }
      if (parameters.phone != null) {
        if (parameters.phone!.startsWith('0')) {
          dataMap['phone'] = parameters.phone!.substring(1);
        }
      }
      dataMap['device_token'] = devToken;
      var response = await apiHelper.postData(
        AppConfig.registerWithDataBase(),
        lang: langRepo.lang ?? "ar",
        data: dataMap,
        typeJSON: true,
      );
      final data = jsonDecode(response);
      GlobalResponseModel globalResponseModel = GlobalResponseModel.fromJson(data);
      if (validString(globalResponseModel.showError()) || data['data'] == null) {
        debugPrint('AuthRepo.registerWithDataBase error: ${globalResponseModel.showError()}');
        return Left(globalResponseModel.showError() ?? globalResponseModel.message ?? getServerError());
      }
      UserModel userModel = UserModel.fromJson(data);
      if (validString(userModel.showError())) {
        return Left(
          userModel.showError(),
        );
      }
      if (userModel.userData.token.isNotEmpty) {
        _saveUser(userModel.userData, true);
      }
      return Right(userModel);
    } catch (e, s) {
      log('$e e.strng');
      log(s.toString());
      return Left(getServerError());
    }
  }


  Future<Either<String, GlobalResponseModel>> registerWithOtp({required ProfileParameters parameters}) async {
    try {
      final Map<String, dynamic> data = parameters.toMap();
      final devToken = await setupFCM.getFcmToken();
      debugPrint("data $data");

      if (parameters.image != null) {
        data['avatar'] = await prepareImageForUpload(parameters.image!);
      }

      if (parameters.phone != null) {
        if (parameters.phone!.startsWith('0')) {
          data["phone"] = parameters.phone!.substring(1);
        }
      }

      // if (parameters.name != null) {
      //   data["name"] = parameters.name;
      // }

      if (parameters.email != null) {
        data["email"] = parameters.email;
      }

      if (parameters.stateId != null) {
        data["city_id"] = parameters.stateId;
      }

      if (parameters.countryId != null) {
        data["country_id"] = parameters.countryId;
      }
      data['device_token'] = devToken;
      var response = await apiHelper.postData(
        AppConfig.registerWithOtp(),
        lang: langRepo.lang ?? "ar",
        data: data,
      );
      final dataResponse = jsonDecode(response);
      GlobalResponseModel globalResponseModel = GlobalResponseModel.fromJson(dataResponse);
      if (validString(globalResponseModel.showError())) {
        return Left(globalResponseModel.showError());
      }

      return Right(globalResponseModel);
    } catch (e, s) {
      log(e.toString());
      log(s.toString());
      return Left(getServerError());
    }
  }

  // Future<void> firebaseSendOtpCodeToUserNew(
  //     {required String phone,
  //     required PhoneCodeSent codeSent,
  //     required PhoneVerificationFailed verificationFailed}) async {
  //   firebaseAuth.verifyPhoneNumber(
  //     phoneNumber: phone,
  //     timeout: const Duration(seconds: 120),
  //     verificationCompleted: (AuthCredential credential) {},
  //     verificationFailed: verificationFailed,
  //     codeSent: codeSent,
  //     codeAutoRetrievalTimeout: (verificationId) {},
  //   );
  // }
  //
  // Future<Either<String, UserCredential>> firebaseCheckOtpNew(
  //     {required String otp, required String verificationId}) async {
  //   AuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: otp);
  //   UserCredential? firebaseUserCredential;
  //   String firebaseError = '';
  //   firebaseAuth.signInWithCredential(credential).then((value) {
  //     if (value.user != null) {
  //       firebaseUserCredential = value;
  //     }
  //   }).catchError((error) {
  //     debugPrint(
  //       error.toString(),
  //     );
  //     firebaseError = error.toString();
  //   });
  //   if (firebaseUserCredential != null) {
  //     return Right(firebaseUserCredential!);
  //   } else {
  //     return Left(firebaseError);
  //   }
  // }

  // _saveUser(UserModel? userModel, [bool rememberMe = true]) async {
  //   debugPrint('AuthRepo._saveUser');
  //   user = userModel!.userData;
  //   if (user!.access_token.isNotEmpty) {
  //     token = user!.access_token;
  //   }
  //   // await cacheHelper.put(kUserToken, token);
  //   await AppBloc().loggedIn(user!);
  //   if (rememberMe) {
  //     await cacheHelper.put(kUserKey, user!.toJson());
  //   }
  // }
  _saveUser(UserData? userModel, [bool rememberMe = true]) async {
    debugPrint('AuthRepo._saveUser');
    user = userModel;
    token = user!.token;
    await AppBloc().loggedIn(userModel!);
    await CartCountBloc().getCartCount();
    await NotificationsCountBloc().getNotificationsCount();
    if (rememberMe) {
      await cacheHelper.put(kUserKey, user!.toJson());
    }
  }

  _removeUser() async {
    user = null;
    token = null;
    await AppBloc().loggedOut();
    await NotificationsCountBloc().clear();
    await CartCountBloc().clear();
    await cacheHelper.clear(kUserKey);
  }

  Future<bool> checkUser() async {
    final userJson = await cacheHelper.get(kUserKey);
    if (userJson == null) {
      return false;
    }
    debugPrint('AuthRepo.checkUser $userJson');
    final UserModel userModel = UserModel.fromJson(userJson);
    user = userModel.userData;
    token = user!.token;
    await CartCountBloc().getCartCount();
    return true;
  }

  Future<Either<String, PickUpImageModel>> pickUpGalleryImage() async {
    // Request permission to access the gallery
    final bool permission = await checkForProfileImagePermission();

    if (permission) {
      // If permission is granted, pick the image
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        profileImageFile = File(pickedFile.path);
        debugPrint('${pickedFile.path}   Path');
        return Right(PickUpImageModel(profileImageFile, pickedFile.path));
      } else {
        return Left('No image selected');
      }
    } else {
      // Handle any other cases like restricted or limited
      return Left('Permission denied');
    }
  }

  Future<bool> checkForProfileImagePermission() async {
    var status = await Permission.storage.status;
    if (Platform.isAndroid) {
      if (await di<DeviceInfoClass>().getAndroidSdkVersion() >= 33) {
        status = await Permission.photos.status;
        debugPrint(status.toString());
      }
    }
    if (status.isGranted) {
      return true;
    } else {
      return false;
    }
  }

  Future<Either<Failure, UserModel>> sendSocialTokenToApi({required String idToken, required String provider}) async {
    try {
      final devToken = await setupFCM.getFcmToken();
      final response = await apiHelper.postData(
        AppConfig.socialLoginEndpoint(),
        lang: langRepo.lang,
        typeJSON: true,
        data: {
          'token': idToken,
          'provider': provider,
          'device_token': devToken,
        },
      );
      final data = jsonDecode(response);
      UserModel userModel = UserModel.fromJson(data);
      if (validString(
        userModel.showError(),
      )) {
        return Left(
          userModel.showError(),
        );
      }
      return Right(userModel);
    } catch (e) {
      return Left(ServerFailure(message: getServerError()));
    }
  }

  Future<Either<Failure, UserModel>> signInWithGoogle() async {
    try {
      final serverClientId = Platform.isAndroid
          ? "788815495776-el9o5qrisarbng3c1j6lf5f0o9l7dsu8.apps.googleusercontent.com"
          : '788815495776-vsp6453lpm1o2en1gcn6s0267mk5krfv.apps.googleusercontent.com';
      // Create a GoogleSignIn instance with the web client ID
      final GoogleSignIn googleSignIn = GoogleSignIn(
        scopes: ['email', 'profile'],
        // This is the crucial part - you need to provide your web client ID
        serverClientId: serverClientId,
      );

      // Ensure a fresh sign-in by signing out first
      await googleSignIn.signOut();

      // Begin the sign-in process
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser == null) {
        return left(ServerFailure(message: 'Sign in aborted by user'));
      }

      // Get authentication details
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // Log the tokens for debugging
      debugPrint('Google User Email: ${googleUser.email}');
      debugPrint('Google Auth accessToken: ${googleAuth.accessToken}');

      if (googleAuth.idToken == null) {
        return Left(ServerFailure(message: 'error signing in with Google'));
      }

      // Send token to your backend
      final result = await sendSocialTokenToApi(idToken: googleAuth.accessToken!, provider: 'google');
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      return result.fold(
        (failure) => Left(failure),
        (r) async {
          AppBloc().loggedIn(r.userData);
          _saveUser(r.userData, true);
          return Right(r);
        },
      );
      // Create OAuth credential

      // Sign in to Firebase with the credential
    } catch (e) {
      debugPrint('Google Sign-In Error: $e');
      if (e.toString().toLowerCase().contains('access_denied')) {
        return Left(ServerFailure(message: 'Sign in aborted by user'));
      }
      return Left(ServerFailure(message: 'error ${e.toString()}'));
    }
  }

  Future<Either<Failure, UserModel>> signInWithApple() async {
    if (kIsWeb || Platform.isAndroid) {
      return Future.value(Left(ServerFailure(message: 'Apple Sign-In is not supported on this platform')));
    }
    try {
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      // Get the ID token from the credential
      final idToken = appleCredential.identityToken;
      debugPrint('Apple User Email: ${appleCredential.email ?? "Not provided"}');
      debugPrint('Apple User Name: ${appleCredential.givenName ?? ""} ${appleCredential.familyName ?? ""}');
      debugPrint('Apple User ID: ${appleCredential.userIdentifier}');

      if (idToken == null) {
        return Left(ServerFailure(message: 'Sign in aborted by user'));
      }
      final result = await sendSocialTokenToApi(idToken: idToken, provider: 'apple');
      return result.fold(
        (failure) => Left(failure),
        (r) async {
          AppBloc().loggedIn(r.userData);
          _saveUser(r.userData, true);
          return Right(r);
        },
      );
    } catch (e) {
      debugPrint('Apple Sign-In Errrrror: $e');
      return Left(ServerFailure(message: 'Sign in aborted by user'));
    }
  }
}
