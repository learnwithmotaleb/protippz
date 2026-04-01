import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../core/app_routes.dart';
import '../data/services/api_check.dart';
import '../data/services/api_client.dart';
import '../data/services/app_url.dart';
import '../data/services/google_sign_In_service.dart';
import '../global/helper/local_db/local_db.dart';
import '../global/widgets/toast_message/toast_message.dart';
import '../utils/app_constants.dart';

class GoogleAuthController extends GetxController {
  RxBool isGoogleLogin = false.obs;

  ///=====================================Google sign in================================
  Future googleSignIn() async {
    isGoogleLogin.value = true;

    try {
      final user = await GoogleSignInService.login();

      if (user != null) {
        log('===== GOOGLE USER INFO =====');
        log('Name: ${user.displayName}');
        log('Email: ${user.email}');
        log('ID: ${user.id}');
        log('Photo: ${user.photoUrl}');

        final googleAuth = await user.authentication;

        log('===== GOOGLE AUTH TOKENS =====');
        log('ID Token: ${googleAuth.idToken}');
        log('Access Token: ${googleAuth.accessToken}');

        /// 🔥 IMPORTANT: pass full auth object
        await googleAuthCall(user, googleAuth);

      } else {
        log('❌ Google Sign-In cancelled by user');
        isGoogleLogin.value = false;
      }
    } catch (exception) {
      log('❌ Google Sign-In error: $exception');
      isGoogleLogin.value = false;
    }
  }

  ///=======================================Google Auth================================
  Future googleAuthCall(user, googleAuth) async {
    isGoogleLogin.value = true;
    refresh();

    /// ✅ Full debug body
    Map<String, dynamic> body = {
      "name": user.displayName ?? '',
      "username": user.displayName ?? '',
      "email": user.email ?? '',
      "profile_image": user.photoUrl ?? '',
      "inviteToken": googleAuth.idToken ?? '',
    };

    try {
      log('===== API REQUEST BODY =====');
      log(jsonEncode(body));

      debugPrint('➡️ URL: ${ApiUrl.googleAuth}');

      var response = await ApiClient.postData(
        ApiUrl.googleAuth,
        jsonEncode(body),
        headers: {
          "Content-Type": "application/json",
        },
      );

      log('===== API RESPONSE =====');
      log('Status Code: ${response.statusCode}');
      log('Body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {

        final data = response.body['data'];
        final String? token = data?["accessToken"];

        if (token != null) {
          await SharePrefsHelper.setString(AppConstants.bearerToken, token);

          log('✅ Token Saved: $token');

          Get.offAllNamed(AppRoute.homeScreen);

          toastMessage(
            message: response.body["message"] ?? "Login Success",
          );

        } else {
          log('❌ accessToken NULL');
          toastMessage(message: 'Invalid response from server');
        }

      } else {
        log('❌ API ERROR');
        ApiChecker.checkApi(response);
      }

    } catch (error) {
      log('❌ API Exception: $error');
      toastMessage(message: 'Google authentication failed');
    } finally {
      isGoogleLogin.value = false;
      refresh();
    }
  }
}