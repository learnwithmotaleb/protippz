import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:protippz/app/controller/player_tippz_history_controller.dart';
import 'package:protippz/app/data/services/api_check.dart';
import 'package:protippz/app/data/services/api_client.dart';
import 'package:protippz/app/data/services/app_url.dart';
import 'package:protippz/app/global/widgets/custom_button/custom_button.dart';
import 'package:protippz/app/global/widgets/custom_loader/custom_loader.dart';
import 'package:protippz/app/global/widgets/toast_message/toast_message.dart';
import 'package:protippz/app/utils/app_colors.dart';
import 'package:protippz/app/utils/app_strings.dart';

class EmailAddController extends GetxController {
  final emailController = TextEditingController();
  final pinCodeController = TextEditingController();

  RxBool isAddEmail = false.obs;
  RxBool isAddEmailVerify = false.obs;

  String activationCode = "";

  void setLoading(RxBool flag, bool value) {
    flag(value);
  }

  /// Add Email
  Future<void> addEmail() async {
    setLoading(isAddEmail, true);

    Map<String, String> body = {"email": emailController.text};
    var response = await ApiClient.postData(ApiUrl.addEmail, jsonEncode(body));

    setLoading(isAddEmail, false);

    if (response.statusCode == 200) {
      toastMessage(message: response.body["message"]);
      Get.back();
      showOtpDialog();
    } else if (response.statusCode == 400) {
      toastMessage(message: response.body["message"]);
    } else {
      ApiChecker.checkApi(response);
    }
  }
  final PlayerTippzHistoryController profileController = Get.find<PlayerTippzHistoryController>();

  /// Verify Email with OTP
  Future<void> addEmailVerify() async {
    setLoading(isAddEmailVerify, true);

    int resetCode = int.tryParse(activationCode) ?? 0;
    Map<String, dynamic> body = {
      "email": emailController.text,
      "verifyCode": resetCode,
    };

    var response =
    await ApiClient.postData(ApiUrl.addEmailVerify, jsonEncode(body));

    setLoading(isAddEmailVerify, false);

    if (response.statusCode == 200) {
      profileController.getTeamProfile();
      profileController.getPlayerProfile();
      toastMessage(message: response.body["message"]);
    } else {
      ApiChecker.checkApi(response);
    }
  }

  /// Show OTP Dialog
  void showOtpDialog() {
    final formKey = GlobalKey<FormState>();

    Get.defaultDialog(
      backgroundColor: Colors.blueGrey,
      title: 'Enter Code',
      content: Obx(() {
        return Form(
          key: formKey,
          child: Column(
            children: [
              CustomPinCodeField(
                controller: pinCodeController,
                onCompleted: (value) {
                  activationCode = value;
                },
              ),
              SizedBox(height: 15.h),
              isAddEmail.value
                  ? const CustomLoader()
                  : CustomButton(
                onTap: () {
                  if (formKey.currentState!.validate()) {
                    Get.back();
                    addEmailVerify();
                  }
                },
                title: AppStrings.verifyCode,
              ),
            ],
          ),
        );
      }),
    );
  }
}

class CustomPinCodeField extends StatelessWidget {
  final TextEditingController controller;
  final Function(String)? onCompleted;

  const CustomPinCodeField({
    required this.controller,
    this.onCompleted,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      textStyle: const TextStyle(color: AppColors.gray500),
      keyboardType: TextInputType.phone,
      cursorColor: AppColors.gray500,
      appContext: context,
      controller: controller,
      onCompleted: onCompleted,
      validator: (value) {
        if (value != null && value.length == 5) {
          return null;
        }
        return AppStrings.fieldCantBeEmpty;
      },
      autoFocus: true,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(12),
        fieldHeight: 49.h,
        fieldWidth: 47,
        activeFillColor: AppColors.white50,
        selectedFillColor: AppColors.white50,
        inactiveFillColor: AppColors.white50,
        borderWidth: 0.5,
        activeBorderWidth: 0.8,
        activeColor: AppColors.white50,
      ),
      length: 5,
      enableActiveFill: true,
    );
  }
}
