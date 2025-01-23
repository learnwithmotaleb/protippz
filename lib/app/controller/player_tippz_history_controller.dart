import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:protippz/app/data/models/player_tippz_model.dart';
import 'package:protippz/app/data/services/api_check.dart';
import 'package:protippz/app/data/services/api_client.dart';
import 'package:protippz/app/data/services/app_url.dart';
import 'package:protippz/app/global/widgets/toast_message/toast_message.dart';

import '../utils/app_constants.dart';

class PlayerTippzHistoryController extends GetxController {
  final rxRequestStatus = Status.loading.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  Rx<PlayerTippzData> tippzHistoryData = PlayerTippzData().obs;

  getPlayerTippzHistory() async {
    setRxRequestStatus(Status.loading);
    refresh();
    var response = await ApiClient.getData(ApiUrl.myTipHistory);

    if (response.statusCode == 200) {
      tippzHistoryData.value = PlayerTippzData.fromJson(response.body["data"]);

      print("=======================${tippzHistoryData.value.result?.length}");
      setRxRequestStatus(Status.completed);
      refresh();
    } else {
      if (response.statusText == ApiClient.noInternetMessage) {
        setRxRequestStatus(Status.internetError);
      } else {
        setRxRequestStatus(Status.error);
      }
      ApiChecker.checkApi(response);
    }
  }

  ///=====================================Player Bookmark===========================

  final streeAddressController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final zipCondeController = TextEditingController();
  RxBool isAddress = false.obs;

  addressEdit() async {
    isAddress.value = true;
    refresh();
    Map<String, dynamic> body = {
      "address": {
        "streetAddress": streeAddressController.text,
        "city": cityController.text,
        "state": stateController.text,
        "zipCode": zipCondeController.text
      }
    };
    var response = await ApiClient.patchData(
      ApiUrl.addressEditPlayerAndTeam,
      jsonEncode(body),
    );
    if (response.statusCode == 200) {

      toastMessage(
        message: response.body["message"],
      );
    } else if (response.statusCode == 400) {
      toastMessage(
        message: response.body["message"],
      );
    } else {
      ApiChecker.checkApi(response);
    }
    isAddress.value = false;
    refresh();
  }



  @override
  void onInit() {
    getPlayerTippzHistory();
    super.onInit();
  }
}
