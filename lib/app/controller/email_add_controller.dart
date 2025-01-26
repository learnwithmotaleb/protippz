import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:protippz/app/data/services/api_check.dart';
import 'package:protippz/app/data/services/api_client.dart';
import 'package:protippz/app/data/services/app_url.dart';
import 'package:protippz/app/global/widgets/toast_message/toast_message.dart';

class EmailAddController extends GetxController {
  ///============================ Forget Password ==========================

  final emailController = TextEditingController();
  RxBool isAddEmail = false.obs;

  addEmail() async {
    isAddEmail.value = true;
    refresh();
    Map<dynamic, String> body = {"email": emailController.text};
    var response = await ApiClient.postData(ApiUrl.addEmail, jsonEncode(body));
    isAddEmail.value = false;
    refresh();
    if (response.statusCode == 200) {
      toastMessage(
        message: response.body["message"],
      );
    } else {
      ApiChecker.checkApi(response);
    }
    isAddEmail.value = false;
    refresh();
  }

  ///=====================Sign up Otp==========================================

 final pinCodeController = TextEditingController();

  String activationCode = "";
  RxBool isAddEmailVerify = false.obs;

  addEmailVerify() async {
    isAddEmailVerify.value = true;
    refresh();
    int resetCode = int.tryParse(activationCode) ?? 0;

    Map<dynamic, dynamic> body = {
      "email": emailController.text,
      "verifyCode": resetCode
    };

    var response =
        await ApiClient.postData(ApiUrl.addEmailVerify, jsonEncode(body));
    isAddEmailVerify.value = false;
    refresh();
    if (response.statusCode == 200) {
      toastMessage(
        message: response.body["message"],
      );
    } else {
      ApiChecker.checkApi(response);
    }
    isAddEmailVerify.value = false;
    refresh();
  }
}
