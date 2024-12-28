import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:protippz/app/data/models/profile_model/profile_model.dart';
import 'package:protippz/app/data/services/api_check.dart';
import 'package:protippz/app/data/services/api_client.dart';
import 'package:protippz/app/data/services/app_url.dart';
import 'package:protippz/app/global/widgets/toast_message/toast_message.dart';
import 'package:protippz/app/utils/app_constants.dart';

class ProfileController extends GetxController {
  final Rx<Status> rxRequestStatus = Status.loading.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  final RxString imagePath = ''.obs; // Holds the image path
  final Rx<ProfileData> profileModel = ProfileData().obs; // Holds profile data

  // TextEditing Controllers for profile fields
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final userNameController = TextEditingController();
  final addressController = TextEditingController();

  /// Fetch profile data from API
  Future<void> getProfile() async {
    setRxRequestStatus(Status.loading);
    refresh();
    var response = await ApiClient.getData(ApiUrl.getProfile);
    setRxRequestStatus(Status.completed);

    if (response.statusCode == 200) {
      profileModel.value = ProfileData.fromJson(response.body["data"]);
      // setTextFieldValue();
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

//: <<<<<<======🗄️🗄️🗄️🗄️🗄️🗄️💡💡Edit Profile💡💡🗄️🗄️🗄️🗄️🗄️🗄️🗄️>>>>>>>>===========

  RxString image = "".obs;

  Rx<File> imageFile = File("").obs;

  selectImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? getImages =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 15);
    if (getImages != null) {
      imageFile.value = File(getImages.path);
      image.value = getImages.path;
    }
  }

  RxBool isUpdateLoading = false.obs;

  Future<void> updateProfile({Map<String, String>? header}) async {
    isUpdateLoading.value = true;
    update();
    try {
      var data = {
        "name": fullNameController.text,
        "address": addressController.text,
        "phone": phoneNumberController.text,
      };

      var response = await ApiClient.patchMultipartData(
        ApiUrl.profileUpdate,
        data,
        multipartBody: [
          if (imageFile.value.existsSync()) // Ensure the file exists
            MultipartBody("profile_image", imageFile.value),
        ],
      );

      if (response.statusCode == 200) {
        isUpdateLoading.value = false;
        refresh();
        clearField();
        getProfile();
        Get.back();
        toastMessage(message: response.body["message"]);
      } else {
        isUpdateLoading.value = false;
        refresh();
        ApiChecker.checkApi(response);
      }
    } catch (e) {
      debugPrint("Error in updateProfile: $e");
    }
  }




  clearField() {
    fullNameController.clear();
    phoneNumberController.clear();
    addressController.clear();
  }

  /// Initialize the profile when the controller is loaded
  @override
  void onInit() {
    getProfile();
    super.onInit();
  }
}
