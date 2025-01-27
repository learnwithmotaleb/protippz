import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:protippz/app/controller/player_tippz_history_controller.dart';
import 'package:protippz/app/controller/withdraw_team_and_player_controller.dart';
import 'package:protippz/app/core/app_routes.dart';
import 'package:protippz/app/core/custom_assets/assets.gen.dart';
import 'package:protippz/app/global/widgets/custom_appbar/custom_appbar.dart';
import 'package:protippz/app/global/widgets/custom_button/custom_button.dart';
import 'package:protippz/app/global/widgets/custom_from_card/custom_from_card.dart';
import 'package:protippz/app/global/widgets/custom_loader/custom_loader.dart';
import 'package:protippz/app/global/widgets/custom_payment_card/custom_payment_card.dart';
import 'package:protippz/app/global/widgets/custom_text/custom_text.dart';
import 'package:protippz/app/global/widgets/toast_message/toast_message.dart';
import 'package:protippz/app/utils/app_colors.dart';
import 'package:protippz/app/utils/app_strings.dart';

class WithdrawScreen extends StatelessWidget {
  WithdrawScreen({super.key});

  final PlayerTippzHistoryController profileController = Get.find<PlayerTippzHistoryController>();
  final WithdrawTeamAndPlayerController withdrawController = Get.find<WithdrawTeamAndPlayerController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg500,
      appBar: const CustomAppBar(
        appBarContent: AppStrings.withdrawFunds,
        iconData: Icons.arrow_back,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Obx(() {
          bool isAmountEntered = withdrawController.amountController.text.isNotEmpty;

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomFromCard(
                  title: 'Enter Amount',
                  controller: withdrawController.amountController,
                  validator: (v) {
                    if (v == null || v.isEmpty) {
                      return 'Please enter an amount';
                    }
                    return null;
                  },
                ),
                const CustomText(
                  top: 10,
                  bottom: 10,
                  text: AppStrings.withdrawOptions,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColors.gray500,
                ),
                Obx(() => CustomPaymentCard(
                  title: "Ach",
                  icon: Assets.images.ach.image(),
                  isSelected: withdrawController.selectedPaymentMethod.value == "Ach",
                  onTap: isAmountEntered
                      ? () {
                    withdrawController.selectedPaymentMethod.value = "Ach";
                  }
                      : null,
                )),
                Obx(() => CustomPaymentCard(
                  title: "Check",
                  icon: Assets.images.check.image(),
                  isSelected: withdrawController.selectedPaymentMethod.value == "Check",
                  onTap: isAmountEntered
                      ? () {
                    withdrawController.selectedPaymentMethod.value = "Check";
                  }
                      : null,
                )),
                Gap(12.h),
                withdrawController.isAchLoading.value
                    ? const CustomLoader()
                    : CustomButton(
                  isRadius: true,
                  onTap: () {
                    if (!isAmountEntered) {
                      toastMessage(message: "Please enter a valid amount");
                      return;
                    }

                    if (withdrawController.selectedPaymentMethod.value == "Ach") {
                      bool isPlayerStripeConnected = profileController.playerGetProfileData.value.isStripeConnected ?? false;
                      bool isTeamStripeConnected = profileController.teamGetProfileData.value.isStripeConnected ?? false;

                      if (!isPlayerStripeConnected && !isTeamStripeConnected) {
                        withdrawController.stripeConnect();
                      } else {
                        withdrawController.withdrawAch();
                      }
                    } else if (withdrawController.selectedPaymentMethod.value == "Check") {
                      Get.toNamed(AppRoute.withdrawCheck);
                    } else {
                      toastMessage(message: "Please select a payment method");
                    }
                  },
                  title: AppStrings.continues,
                  fillColor: AppColors.green500,
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}



