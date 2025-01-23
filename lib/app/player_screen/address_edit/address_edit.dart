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

class AddressEdit extends StatelessWidget {
  AddressEdit({super.key});

  final PlayerTippzHistoryController controller =
      Get.find<PlayerTippzHistoryController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg500,

      ///============================ Address Appbar===============================

      appBar: const CustomAppBar(
        appBarContent: AppStrings.address,
        iconData: Icons.arrow_back,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Obx(
           () {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomText(
                    text: AppStrings.enterAddressDetails,
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    color: AppColors.gray500,
                  ),
                  SizedBox(
                    height: 12.h,
                  ),

                  ///=====================Street Address=================
                  CustomFromCard(
                      hinText: AppStrings.typeHere,
                      title: AppStrings.streetAddress,
                      controller: controller.streeAddressController,
                      validator: (v) {}),
                  SizedBox(
                    height: 12.h,
                  ),

                  ///=====================City=================
                  CustomFromCard(
                      hinText: AppStrings.typeHere,
                      title: AppStrings.city,
                      controller: controller.cityController,
                      validator: (v) {}),
                  SizedBox(
                    height: 12.h,
                  ),

                  ///=====================State=================
                  CustomFromCard(
                      hinText: AppStrings.typeHere,
                      title: AppStrings.state,
                      controller: controller.stateController,
                      validator: (v) {}),
                  SizedBox(
                    height: 12.h,
                  ),

                  ///=====================Zip Code=================
                  CustomFromCard(
                      hinText: AppStrings.typeHere,
                      title: AppStrings.zipCode,
                      controller: controller.zipCondeController,
                      validator: (v) {}),
                  SizedBox(
                    height: 12.h,
                  ),
                  controller.isAddress.value
                      ? const CustomLoader()
                      : CustomButton(
                          isRadius: true,
                          onTap: () {
                            controller.addressEdit();
                          },
                          title: AppStrings.save,
                        )
                ],
              ),
            );
          }
        ),
      ),
    );
  }
}
