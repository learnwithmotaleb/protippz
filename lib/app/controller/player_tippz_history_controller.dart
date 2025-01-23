import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:protippz/app/data/models/player_section/player_get_profile.dart';
import 'package:protippz/app/data/models/player_tippz_model.dart';
import 'package:protippz/app/data/models/team_section/team_get_profile.dart';
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

  ///=====================================Dynamic Address Edit===========================
  final streeAddressController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final zipCondeController = TextEditingController();
  RxBool isAddress = false.obs;

  editAddress(String role) async {
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

    // Determine the endpoint based on the role
    String endpoint =
        role == 'player' ? ApiUrl.addressEditPlayer : ApiUrl.addressEditTeam;

    var response = await ApiClient.patchData(
      endpoint, // Dynamic endpoint
      jsonEncode(body),
    );

    if (response.statusCode == 200) {
      Get.back();
      getPlayerProfile();
      getTeamProfile();
      toastMessage(message: response.body["message"]);
    } else if (response.statusCode == 400) {
      toastMessage(message: response.body["message"]);
    } else {
      ApiChecker.checkApi(response);
    }

    isAddress.value = false;
    refresh();
  }

  ///=====================================Team Tax===========================

  final fullNameController = TextEditingController();
  final taxIdController = TextEditingController();
  final addressController = TextEditingController();

  RxBool isTeamTax = false.obs;

  teamTax(String role) async {
    isTeamTax.value = true;
    refresh();
    Map<String, dynamic> body = {
      "taxInfo": {
        "fullname": fullNameController.text,
        "taxId": taxIdController.text,
        "address": addressController.text,
      }
    };

    String endpoint =
        role == 'player' ? ApiUrl.addressEditPlayer : ApiUrl.addressEditTeam;
    var response = await ApiClient.patchData(
      endpoint,
      jsonEncode(body),
    );
    if (response.statusCode == 200) {
      Get.back();
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
    isTeamTax.value = false;
    refresh();
  }

  final Rx<PlayerGetProfileData> playerGetProfileData =
      PlayerGetProfileData().obs; // Holds profile data
  getPlayerProfile() async {
    setRxRequestStatus(Status.loading);
    refresh();
    var response = await ApiClient.getData(ApiUrl.getProfile);
    setRxRequestStatus(Status.completed);

    if (response.statusCode == 200) {
      playerGetProfileData.value =
          PlayerGetProfileData.fromJson(response.body["data"]);
      print(
          'playerGetProfileData==================${playerGetProfileData.value.totalTips}');
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

  final Rx<TeamGetProfileData> teamGetProfileData =
      TeamGetProfileData().obs; // Holds profile data
  getTeamProfile() async {
    setRxRequestStatus(Status.loading);
    refresh();
    var response = await ApiClient.getData(ApiUrl.getProfile);
    setRxRequestStatus(Status.completed);

    if (response.statusCode == 200) {
      teamGetProfileData.value =
          TeamGetProfileData.fromJson(response.body["data"]);
      print('teamGetProfileData==================${teamGetProfileData.value}');

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

  @override
  void onInit() {
    getPlayerTippzHistory();
    getPlayerProfile();
    getTeamProfile();
    super.onInit();
  }
}
