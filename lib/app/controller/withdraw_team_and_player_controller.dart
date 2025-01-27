import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:protippz/app/controller/player_tippz_history_controller.dart';
import 'package:protippz/app/data/services/api_check.dart';
import 'package:protippz/app/data/services/api_client.dart';
import 'package:protippz/app/data/services/app_url.dart';
import 'package:protippz/app/global/widgets/toast_message/toast_message.dart';
import 'package:protippz/app/player_screen/withdraw_screen/inner_screen/webview_screen.dart';

class WithdrawTeamAndPlayerController extends GetxController {
  ///=====================================CheckWithdraw===========================
  final amountController = TextEditingController();
  final fullNameController = TextEditingController();
  final streetAddressController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final zipCodeController = TextEditingController();
  final emailController = TextEditingController();

  final PlayerTippzHistoryController profileController =
      Get.find<PlayerTippzHistoryController>();

  ///================================Withdraw Check===============================
  RxBool isCheckLoading = false.obs;

  withdrawCheckMethod() async {
    isCheckLoading.value = true;
    refresh();
    Map<String, dynamic> body = {
      "amount": int.tryParse(amountController.text),
      "withdrawOption": "Check",
      "fullName": fullNameController.text,
      "streetAddress": streetAddressController.text,
      "city": cityController.text,
      "state": stateController.text,
      "zipCode": int.tryParse(zipCodeController.text),
      "email": emailController.text
    };
    var response = await ApiClient.postData(
      ApiUrl.withdrawFunds,
      jsonEncode(body),
    );
    if (response.statusCode == 200) {
      Get.back();
      toastMessage(
        message: response.body["message"],
      );
    } else if (response.statusCode == 401) {
      ApiChecker.checkApi(response);
      toastMessage(
        message: response.body["message"],
      );
    } else {
      ApiChecker.checkApi(response);
    }
    isCheckLoading.value = false;
    refresh();
  }

  ///================================StripeConnect===============================
  RxBool isStripConnect = false.obs;

  stripeConnect() async {
    isStripConnect.value = true;
    refresh();

    Map<String, dynamic> body = {};
    var response = await ApiClient.postData(
      ApiUrl.stripeConnect,
      jsonEncode(body),
    );

    if (response.statusCode == 201) {
      String generatedLink =
          response.body["data"]; // Get the link from response
      toastMessage(
        message: response.body["message"],
      );

      // Navigate to WebView to show the link
      Get.to(() => WebViewScreen(url: generatedLink));
    } else if (response.statusCode == 401) {
      ApiChecker.checkApi(response);
      toastMessage(
        message: response.body["message"],
      );
    } else {
      ApiChecker.checkApi(response);
    }

    isStripConnect.value = false;
    refresh();
  }

  ///================================Strip Update===============================
  RxBool isStripUpdate = false.obs;

  stripeUpdate() async {
    isStripUpdate.value = true;
    refresh();

    Map<String, dynamic> body = {};
    var response = await ApiClient.postData(
      ApiUrl.stripeUpdate,
      jsonEncode(body),
    );

    if (response.statusCode == 201) {
      String generatedLink =
          response.body["data"]['link']; // Get the link from response
      toastMessage(
        message: response.body["message"],
      );

      // Navigate to WebView to show the link
      Get.to(() => WebViewScreen(url: generatedLink));
    } else if (response.statusCode == 401) {
      ApiChecker.checkApi(response);
      toastMessage(
        message: response.body["message"],
      );
    } else {
      ApiChecker.checkApi(response);
    }

    isStripUpdate.value = false;
    refresh();
  }

  ///================================Withdraw Ach===============================
  final RxString selectedPaymentMethod = "Stripe".obs;
  final RxBool isAchLoading = false.obs;

  withdrawAch() async {
    isAchLoading.value = true;

    try {
      final Map<String, dynamic> body = {
        "amount": int.tryParse(amountController.text),
      };

      final response = await ApiClient.postData(
        ApiUrl.withdrawAch,
        jsonEncode(body),
      );

      print("========================${response.body}");

      if (response.statusCode == 200) {
        profileController.getTeamProfile();
        profileController.getPlayerProfile();
        Get.back();
        toastMessage(
          message: response.body["message"],
        );
      } else if (response.statusCode == 400) {
        final String errorMessage = response.body['message'] ?? 'Unknown error';

        if (errorMessage == 'Transfer failed update your bank info') {
          await stripeUpdate();
        } else if (errorMessage == 'You don’t have enough balance') {
          toastMessage(message: errorMessage);
        } else {
          toastMessage(message: errorMessage);
        }
      } else if (response.statusCode == 401) {
        ApiChecker.checkApi(response);
        toastMessage(
          message: response.body["message"] ?? 'Unauthorized access',
        );
      } else {
        ApiChecker.checkApi(response);
      }
    } catch (e) {
      toastMessage(message: "An error occurred: $e");
    } finally {
      isAchLoading.value = false;
    }
  }

}
