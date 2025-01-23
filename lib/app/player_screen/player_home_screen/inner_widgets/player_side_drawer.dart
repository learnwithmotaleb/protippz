import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:protippz/app/core/app_routes.dart';
import 'package:protippz/app/core/custom_assets/assets.gen.dart';
import 'package:protippz/app/global/helper/local_db/local_db.dart';
import 'package:protippz/app/global/widgets/custom_menu_card/custom_menu_card.dart';
import 'package:protippz/app/utils/app_colors.dart';
import 'package:protippz/app/utils/app_constants.dart';
import 'package:protippz/app/utils/app_strings.dart';

import '../../../global/widgets/parmission_button/parmission_button.dart';

class PlayerSideDrawer extends StatefulWidget {
  const PlayerSideDrawer({super.key});

  @override
  State<PlayerSideDrawer> createState() => _PlayerSideDrawerState();
}

class _PlayerSideDrawerState extends State<PlayerSideDrawer> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width > 600
          ? MediaQuery.of(context).size.width / 2
          : MediaQuery.of(context).size.width / 1.5, // Responsive width
      child: Column(
        children: [
          // Header Container
          Container(
            padding: EdgeInsets.only(
              right: 10.w,
              top: 30.h,
            ),
            color: AppColors.white50,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 50.w,
                vertical: 30.h,
              ),
              child: Assets.images.ptis.image(),
            ),
          ),

          // Main Menu
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.h),
              color: AppColors.bg500,
              child: ListView(
                children: [
                  // Settings
                  CustomMenuCard(
                    onTap: () => Get.toNamed(AppRoute.changePasswordScreen),
                    title: AppStrings.changePassword,
                    icon: Assets.icons.settings.svg(),
                    isDevider: true,
                  ),
                  // Terms & Conditions
                  CustomMenuCard(
                    onTap: () => Get.toNamed(AppRoute.termsConditionScreen),
                    title: AppStrings.termsAndCondition,
                    icon: Assets.icons.terms.svg(),
                    isDevider: true,
                  ),
                  // Privacy Policy
                  CustomMenuCard(
                    onTap: () => Get.toNamed(AppRoute.privacyPolicyScreen),
                    title: AppStrings.privacyPolicy,
                    icon: Assets.icons.privacy.svg(),
                    isDevider: true,
                  ),

                  CustomMenuCard(
                    onTap: (){
                      permissionPopUp(
                          title: 'Are you sure you want to log out',
                          context: context,
                          ontapNo: () {
                            Get.back();
                          },
                          ontapYes: () async {
                            await SharePrefsHelper.remove(
                                AppConstants.bearerToken);
                            await SharePrefsHelper.remove(
                                AppConstants.profileID);
                            await SharePrefsHelper.remove(
                                AppConstants.role);

                            print(
                                'remove token========================"${AppConstants.bearerToken}"');
                            print(
                                'remove profileId========================"${AppConstants.profileID}"');

                            Get.offAllNamed(AppRoute.signInScreen);
                          });
                    },
                    title: AppStrings.logout,
                    icon: Assets.icons.logout.svg(),
                    isDevider: true,
                  ),
                  Gap(40.h), // Use `ScreenUtil` for spacing
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
