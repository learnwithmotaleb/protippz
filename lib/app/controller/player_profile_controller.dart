import 'package:get/get.dart';
import 'package:protippz/app/data/models/player_section/player_get_profile.dart';
import 'package:protippz/app/data/models/team_section/team_get_profile.dart';
import 'package:protippz/app/data/services/api_check.dart';
import 'package:protippz/app/data/services/api_client.dart';
import 'package:protippz/app/data/services/app_url.dart';
import 'package:protippz/app/global/helper/local_db/local_db.dart';
import 'package:protippz/app/utils/app_constants.dart';

class PlayerProfileController extends GetxController{
  final Rx<Status> rxRequestStatus = Status.loading.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;


  final Rx<PlayerGetProfileData> playerGetProfileData = PlayerGetProfileData().obs; // Holds profile data
  getPlayerProfile() async {
    setRxRequestStatus(Status.loading);
    refresh();
    var response = await ApiClient.getData(ApiUrl.getProfile);
    setRxRequestStatus(Status.completed);

    if (response.statusCode == 200) {
      playerGetProfileData.value = PlayerGetProfileData.fromJson(response.body["data"]);
        print('playerGetProfileData==================${playerGetProfileData.value.totalTips}');
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

  final Rx<TeamGetProfileData> teamGetProfileData = TeamGetProfileData().obs; // Holds profile data
  getTeamProfile() async {
    setRxRequestStatus(Status.loading);
    refresh();
    var response = await ApiClient.getData(ApiUrl.getProfile);
    setRxRequestStatus(Status.completed);

    if (response.statusCode == 200) {
      teamGetProfileData.value = TeamGetProfileData.fromJson(response.body["data"]);
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
    getPlayerProfile();
    getTeamProfile();
    super.onInit();
  }
}