import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:protippz/app/controller/home_controller.dart';
import 'package:protippz/app/controller/profile_controller.dart';
import 'package:protippz/app/global/widgets/custom_appbar/custom_appbar.dart';
import 'package:protippz/app/global/widgets/custom_loader/custom_loader.dart';
import 'package:protippz/app/global/widgets/custom_network_image/custom_network_image.dart';
import 'package:protippz/app/global/widgets/custom_text/custom_text.dart';
import 'package:protippz/app/global/widgets/custom_text_field/custom_text_field.dart';
import 'package:protippz/app/global/widgets/genarel_error/genarel_error.dart';
import 'package:protippz/app/global/widgets/reward_card/reward_card.dart';
import 'package:protippz/app/screens/rewardz_screen/inner_widget/otp_veryFy.dart';
import 'package:protippz/app/utils/app_colors.dart';
import 'package:protippz/app/utils/app_constants.dart';
import 'package:protippz/app/utils/app_strings.dart';
import 'package:protippz/app/utils/image_utils.dart';

import 'inner_widget/email_verification_dialog.dart';
import 'inner_widget/info_dialoge.dart';
import 'inner_widget/shirt_from_dialog.dart';

class RewardScreen extends StatefulWidget {
  const RewardScreen({super.key});

  @override
  State<RewardScreen> createState() => _RewardScreenState();
}

class _RewardScreenState extends State<RewardScreen> {
  final HomeController homeController = Get.find<HomeController>();
  final ProfileController profileController = Get.find<ProfileController>();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      profileController.getProfile();
    });
    if (homeController.rewardList.isNotEmpty) {
      homeController.selectedIndex.value = 0;
      homeController.selectedReward(id: homeController.rewardList[0].id ?? '');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg500,
      appBar: const CustomAppBar(
        appBarContent: AppStrings.rewardz,
        iconData: Icons.arrow_back,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        child: Column(
          children: [
            /// ================== Reward Category List ==================
            Obx(() {
              if (homeController.rewardList.isEmpty) {
                return const CustomText(
                  text: 'No Rewards Found',
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: AppColors.gray500,
                );
              }
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(homeController.rewardList.length, (index) {
                    final item = homeController.rewardList[index];
                    final isSelected = homeController.selectedIndex.value == index;

                    return GestureDetector(
                      onTap: () {
                        homeController.selectedIndex.value = index;
                        homeController.selectedReward(id: item.id ?? '');
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: isSelected
                              ? Border.all(color: AppColors.green500, width: 2)
                              : null,
                        ),
                        child: Column(
                          children: [
                            CustomNetworkImage(
                              imageUrl: resolveImageUrl(item.image), // ✅
                              height: 72,
                              width: 73,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            SizedBox(height: 10.h),
                            Text(
                              item.name ?? '',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 12.sp,
                                color: AppColors.gray500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              );
            }),

            Gap(24.h),

            /// ================== Search ==================
            CustomTextField(
              isColor: false,
              inputTextStyle: const TextStyle(color: AppColors.gray500),
              onFieldSubmitted: (value) {
                String selectedRewardId = homeController.selectedRewardId.value;
                if (selectedRewardId.isEmpty && homeController.rewardList.isNotEmpty) {
                  selectedRewardId = homeController.rewardList[0].id ?? '';
                }
                homeController.searchReward(search: value, id: selectedRewardId);
              },
              textEditingController: homeController.searchController,
              hintText: AppStrings.searchReward,
              prefixIcon: const Icon(Icons.search, color: AppColors.gray500),
              fillColor: AppColors.white50,
              fieldBorderColor: AppColors.grey400,
            ),

            Gap(14.h),

            /// ================== Reward Grid ==================
            Expanded(
              child: Obx(() {
                final status = homeController.rxRequestStatus.value;

                if (status == Status.loading) {
                  return const CustomLoader();
                }

                if (status == Status.internetError) {
                  return const Center(
                    child: CustomText(
                      text: 'Please Connect Your Internet',
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: AppColors.gray500,
                    ),
                  );
                }

                if (status == Status.error) {
                  return GeneralErrorScreen(
                    onTap: () {
                      if (homeController.rewardList.isNotEmpty) {
                        homeController.selectedReward(
                          id: homeController.rewardList[0].id ?? '',
                        );
                      }
                    },
                  );
                }

                if (status == Status.completed && homeController.selectRewardList.isEmpty) {
                  return const Center(
                    child: CustomText(
                      text: 'No Rewards Available',
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: AppColors.gray500,
                    ),
                  );
                }

                return GridView.builder(
                  itemCount: homeController.selectRewardList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: MediaQuery.of(context).size.width > 600 ? 3 : 2,
                    crossAxisSpacing: 16.w,
                    mainAxisSpacing: 16.h,
                    childAspectRatio: 1 / 1.9,
                  ),
                  itemBuilder: (context, index) {
                    final data = homeController.selectRewardList[index];
                    return RewardCard(
                      imageUrl: resolveImageUrl(data.rewardImage), // ✅
                      name: data.name ?? '',
                      describe: data.description ?? '',
                      points: data.pointRequired.toString(),
                      onTap: () {
                        final userPoint = profileController.profileModel.value.totalPoint;
                        if (userPoint! >= data.pointRequired!.toInt()) {
                          if (data.category?.deliveryOption == 'Shipping Address') {
                            whenShirtDialog(context);
                          } else if (data.category?.deliveryOption == 'Email') {
                            infoDialogue(context);
                          }
                        } else {
                          Get.snackbar('Insufficient Points', "You don't have enough points.");
                        }
                      },
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  void infoDialogue(BuildContext context) {
    Get.dialog(InfoDialogBox(
      onTapClose: Get.back,
      onTapContinue: () {
        Get.back();
        veryFyEmailAddress(context);
      },
    ));
  }

  void veryFyEmailAddress(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    Get.dialog(EmailVerificationDialog(
      formKey: formKey,
      emailController: homeController.emailController,
      onSendCode: () {
        if (formKey.currentState!.validate()) {
          Get.back();
          homeController.veryFyEmail(
            rewardId: homeController.selectRewardList[0].id ?? '',
            categoryId: homeController.selectRewardList[0].category?.id ?? '',
          );
          veryFyOtp(context);
        }
      },
      onClose: Get.back,
    ));
  }

  void veryFyOtp(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    Get.dialog(OtpVeryEmail(
      formKey: formKey,
      onSendCode: () {
        if (formKey.currentState!.validate()) {
          Get.back();
          homeController.veryFyOtp();
        }
      },
      onClose: Get.back,
      pinController: homeController.pinController,
    ));
  }

  void whenShirtDialog(BuildContext context) {
    Get.dialog(ShirtFormDialog(
      formKey: formKey,
      homeController: homeController,
    ));
  }
}