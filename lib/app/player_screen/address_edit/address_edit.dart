import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:protippz/app/global/widgets/custom_appbar/custom_appbar.dart';
import 'package:protippz/app/global/widgets/custom_button/custom_button.dart';
import 'package:protippz/app/global/widgets/custom_from_card/custom_from_card.dart';
import 'package:protippz/app/global/widgets/custom_text/custom_text.dart';
import 'package:protippz/app/utils/app_colors.dart';
import 'package:protippz/app/utils/app_strings.dart';

class AddressEdit extends StatelessWidget {
  const AddressEdit({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg500,
      appBar: CustomAppBar(
        appBarContent: AppStrings.address,
        iconData: Icons.arrow_back,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
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
                controller: TextEditingController(),
                validator: (v) {}),
            SizedBox(
              height: 12.h,
            ),

            ///=====================City=================
            CustomFromCard(
                hinText: AppStrings.typeHere,
                title: AppStrings.city,
                controller: TextEditingController(),
                validator: (v) {}),
            SizedBox(
              height: 12.h,
            ),

            ///=====================State=================
            CustomFromCard(
                hinText: AppStrings.typeHere,
                title: AppStrings.state,
                controller: TextEditingController(),
                validator: (v) {}),
            SizedBox(
              height: 12.h,
            ),

            ///=====================Zip Code=================
            CustomFromCard(
                hinText: AppStrings.typeHere,
                title: AppStrings.zipCode,
                controller: TextEditingController(),
                validator: (v) {}),
            SizedBox(
              height: 12.h,
            ),

            CustomButton(
              isRadius: true,
              onTap: () {
                Get.back();
              },
              title: AppStrings.save,
            )
          ],
        ),
      ),
    );
  }
}
