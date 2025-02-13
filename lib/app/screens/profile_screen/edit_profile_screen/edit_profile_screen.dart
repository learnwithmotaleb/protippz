import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:protippz/app/controller/profile_controller.dart';
import 'package:protippz/app/core/custom_assets/assets.gen.dart';
import 'package:protippz/app/data/services/app_url.dart';
import 'package:protippz/app/global/widgets/custom_appbar/custom_appbar.dart';
import 'package:protippz/app/global/widgets/custom_button/custom_button.dart';
import 'package:protippz/app/global/widgets/custom_from_card/custom_from_card.dart';
import 'package:protippz/app/global/widgets/custom_image/custom_image.dart';
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
    profileController.fullNameController.text =
        profileController.profileModel.value.name ?? '';
    profileController.phoneNumberController.text =
        profileController.profileModel.value.phone ?? '';
    profileController.addressController.text =
        profileController.profileModel.value.address ?? '';
    profileController.image.value =
        profileController.profileModel.value.profileImage ?? '';
    print("Received Image: =============${profileController.image.value}");

    super.initState();
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
                ///================== Edit Image==================
                // Align(
                //   alignment: Alignment.center,
                //   child: GestureDetector(
                //     onTap: () {
                //       profileController.selectImage();
                //     },
                //     child: (profileController.image.value.isNotEmpty)
                //         ? Container(
                //       height: 94.h,
                //       width: 94.w,
                //       decoration: BoxDecoration(
                //         shape: BoxShape.circle,
                //         color: Colors.grey,
                //         image: DecorationImage(
                //           image: FileImage(File(profileController.image.value)),
                //           fit: BoxFit.cover,
                //         ),
                //       ),
                //     )
                //         : Stack(
                //       children: [
                //         CustomNetworkImage(
                //           boxShape: BoxShape.circle,
                //           imageUrl: AppConstants.profileImage,
                //           backgroundColor: AppColors.green50,
                //           height: 94.h,
                //           width: 94.w,
                //         ),
                //         Positioned(
                //           right: 0,
                //           bottom: 0,
                //           child: Container(
                //             height: 30.h,
                //             width: 30.w,
                //             decoration: const BoxDecoration(
                //               color: AppColors.green500,
                //               shape: BoxShape.circle,
                //             ),
                //             child: Assets.icons.photoCamera.svg(),
                //           ),
                //         )
                //       ],
                //     ),
                //   ),
                // ),
                Align(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onTap: () {
                      profileController.selectImage();
                    },
                    child: Obx(() {
                      if (profileController.image.value.isNotEmpty) {
                        String imagePath = profileController.image.value;

                        if (imagePath.startsWith('/data') ||
                            imagePath.startsWith('/storage')) {
                          return ClipOval(
                            child: Image.file(
                              File(imagePath),
                              height: 128.h,
                              width: 128.w,
                              fit: BoxFit.cover,
                            ),
                          );
                        } else {
                          return ClipOval(
                            child: Image.network(
                              "${ApiUrl.baseUrl}/$imagePath",
                              height: 128.h,
                              width: 128.w,
                              fit: BoxFit.cover,
                            ),
                          );
                        }
                      } else {
                        return Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            ClipOval(
                                child: CustomNetworkImage(
                                    imageUrl: AppConstants.profileImage,
                                    height: 94,
                                    width: 94)),
                            Positioned(
                              right: 5,
                              bottom: 5,
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                child:
                                    Icon(Icons.camera_alt, color: Colors.black),
                              ),
                            ),
                          ],
                        );
                      }
                    }),
                  ),
                ),

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
                            onTap: () {
                              profileController.updateProfile();
                            },
                            title: AppStrings.save,
                          ),
                  ],
                )
              ],
            );
          }),
        ),
      ),
    );
  }
}
