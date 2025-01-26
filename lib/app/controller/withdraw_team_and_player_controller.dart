import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
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

 ///================================Withdraw Check===============================
 RxBool isCheckLoading = false.obs;

 withdrawCheckMethod() async {
   isCheckLoading.value = true;
   refresh();
   Map<String, dynamic> body = {
     "amount": int.tryParse(amountController.text),
     "withdrawOption": "Check",
     "fullName":fullNameController.text,
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
     String generatedLink = response.body["data"]; // Get the link from response
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



}
