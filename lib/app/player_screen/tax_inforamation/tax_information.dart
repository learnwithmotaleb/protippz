import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:protippz/app/controller/player_tippz_history_controller.dart';
import 'package:protippz/app/global/widgets/custom_appbar/custom_appbar.dart';
import 'package:protippz/app/global/widgets/custom_button/custom_button.dart';
import 'package:protippz/app/global/widgets/custom_from_card/custom_from_card.dart';
import 'package:protippz/app/global/widgets/custom_loader/custom_loader.dart';
import 'package:protippz/app/global/widgets/custom_text/custom_text.dart';
import 'package:protippz/app/utils/app_colors.dart';
import 'package:protippz/app/utils/app_strings.dart';

class TaxInformation extends StatelessWidget {
  TaxInformation({super.key});

  final PlayerTippzHistoryController controller =
      Get.find<PlayerTippzHistoryController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg500,
      appBar: const CustomAppBar(
        appBarContent: AppStrings.taxInformation,
        iconData: Icons.arrow_back,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Obx(
           () {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomText(
                    text: AppStrings.enterYourTax,
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    color: AppColors.gray500,
                  ),
                  SizedBox(
                    height: 12.h,
                  ),

                  ///=====================fullNameController=================
                  CustomFromCard(
                      hinText: AppStrings.typeHere,
                      title: AppStrings.fullName,
                      controller: controller.fullNameController,
                    validator: (value) {
                      if (value == null || value.toString().isEmpty) {
                        return AppStrings.fieldCantBeEmpty;
                      }
                      return null;
                    },

                  ),
                  SizedBox(
                    height: 12.h,
                  ),

                  ///=====================taxId=================
                  CustomFromCard(
                      hinText: AppStrings.typeHere,
                      title: AppStrings.taxId,
                      controller: controller.taxIdController,
                    validator: (value) {
                      if (value == null || value.toString().isEmpty) {
                        return AppStrings.fieldCantBeEmpty;
                      }
                      return null;
                    },),
                  SizedBox(
                    height: 12.h,
                  ),

                  ///=====================address=================
                  CustomFromCard(
                      hinText: AppStrings.typeHere,
                      title: AppStrings.address,
                      controller: controller.addressController,
                    validator: (value) {
                      if (value == null || value.toString().isEmpty) {
                        return AppStrings.fieldCantBeEmpty;
                      }
                      return null;
                    },),
                  SizedBox(
                    height: 12.h,
                  ),

                  controller.isTeamTax.value
                      ? const CustomLoader()
                      : CustomButton(
                          isRadius: true,
                          onTap: () {
                            controller.teamTax();
                          },
                          title: AppStrings.save,
                        )
                ],
              );
            }
          ),
        ),
      ),
    );
  }
}
