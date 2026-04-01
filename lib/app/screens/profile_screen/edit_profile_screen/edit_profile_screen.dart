import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:protippz/app/controller/profile_controller.dart';
import 'package:protippz/app/data/services/app_url.dart';
import 'package:protippz/app/global/widgets/custom_appbar/custom_appbar.dart';
import 'package:protippz/app/global/widgets/custom_button/custom_button.dart';
import 'package:protippz/app/global/widgets/custom_from_card/custom_from_card.dart';
import 'package:protippz/app/global/widgets/custom_loader/custom_loader.dart';
import 'package:protippz/app/global/widgets/custom_network_image/custom_network_image.dart';
import 'package:protippz/app/utils/app_colors.dart';
import 'package:protippz/app/utils/app_constants.dart';
import 'package:protippz/app/utils/app_strings.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final ProfileController profileController = Get.find<ProfileController>();

  @override
  void initState() {
    super.initState();
    profileController.fullNameController.text =
        profileController.profileModel.value.name ?? '';
    profileController.phoneNumberController.text =
        profileController.profileModel.value.phone ?? '';
    profileController.addressController.text =
        profileController.profileModel.value.address ?? '';
    profileController.image.value =
        profileController.profileModel.value.profileImage ?? '';
  }

  Widget _buildProfileImage(String imagePath) {
    // 1 — local file picked from gallery
    if (imagePath.startsWith('/data') || imagePath.startsWith('/storage')) {
      return ClipOval(
        child: Image.file(
          File(imagePath),
          height: 128.h,
          width: 128.w,
          fit: BoxFit.cover,
        ),
      );
    }

    // 2 — full external URL (Google profile photo, etc.)
    if (imagePath.startsWith('http')) {
      return ClipOval(
        child: Image.network(
          imagePath,
          height: 128.h,
          width: 128.w,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => _buildPlaceholder(),
        ),
      );
    }

    // 3 — relative path from your own server
    return ClipOval(
      child: Image.network(
        '${ApiUrl.baseUrl}/$imagePath',
        height: 128.h,
        width: 128.w,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => _buildPlaceholder(),
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        ClipOval(
          child: CustomNetworkImage(
            imageUrl: AppConstants.profileImage,
            height: 128,
            width: 128,
          ),
        ),
        Positioned(
          right: 5,
          bottom: 5,
          child: CircleAvatar(
            backgroundColor: Colors.white,
            child: Icon(Icons.camera_alt, color: Colors.black),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg500,
      appBar: const CustomAppBar(
        iconData: Icons.arrow_back_outlined,
        appBarContent: AppStrings.editProfile,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: SingleChildScrollView(
          child: Obx(() {
            return Column(
              children: [
                ///================== Profile Image ==================
                Align(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onTap: profileController.selectImage,
                    child: Obx(() {
                      final imagePath = profileController.image.value;
                      return imagePath.isNotEmpty
                          ? _buildProfileImage(imagePath)
                          : _buildPlaceholder();
                    }),
                  ),
                ),

                Gap(20.h),

                ///================== Form Fields ==================
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomFromCard(
                      title: AppStrings.fullName,
                      controller: profileController.fullNameController,
                      validator: (v) {},
                    ),
                    Gap(12.h),
                    CustomFromCard(
                      title: AppStrings.phoneNumber,
                      controller: profileController.phoneNumberController,
                      validator: (v) {},
                    ),
                    Gap(12.h),
                    CustomFromCard(
                      title: AppStrings.address,
                      controller: profileController.addressController,
                      validator: (v) {},
                    ),
                    Gap(25.h),

                    ///================= Save Button =================
                    profileController.isUpdateLoading.value
                        ? const CustomLoader()
                        : CustomButton(
                      onTap: profileController.updateProfile,
                      title: AppStrings.save,
                    ),
                  ],
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}