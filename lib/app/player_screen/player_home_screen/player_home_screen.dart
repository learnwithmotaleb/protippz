import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:protippz/app/controller/player_tippz_history_controller.dart';
import 'package:protippz/app/core/app_routes.dart';
import 'package:protippz/app/global/helper/local_db/local_db.dart';
import 'package:protippz/app/global/widgets/custom_loader/custom_loader.dart';
import 'package:protippz/app/global/widgets/genarel_error/genarel_error.dart';
import 'package:protippz/app/player_screen/player_home_screen/inner_widgets/player_home_app_bar.dart';
import 'package:protippz/app/player_screen/player_home_screen/inner_widgets/player_side_drawer.dart';
import 'package:protippz/app/screens/no_internet_screen/no_internet_screen.dart';
import 'package:protippz/app/utils/app_colors.dart';
import 'package:protippz/app/utils/app_constants.dart';
import 'package:protippz/app/utils/app_strings.dart';

import 'inner_widgets/address_section.dart';
import 'inner_widgets/navigation_tile.dart';
import 'inner_widgets/player_header_card.dart';
import 'inner_widgets/player_info_row.dart';

class PlayerHomeScreen extends StatelessWidget {
  PlayerHomeScreen({super.key});

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final PlayerTippzHistoryController profileController =
  Get.find<PlayerTippzHistoryController>();

  final RxString role = ''.obs;

  Future<void> checkSavedRole() async {
    role.value = await SharePrefsHelper.getString(AppConstants.role) ?? '';
    if (role.value == 'player') {
      profileController.getPlayerProfile();
    } else if (role.value == 'team') {
      profileController.getTeamProfile();
    }
  }

  @override
  Widget build(BuildContext context) {
    checkSavedRole();

    return Scaffold(
      key: scaffoldKey,
      drawer: const PlayerSideDrawer(),
      backgroundColor: AppColors.bg500,
      body: Obx(() {
        if (role.value.isEmpty) {
          return const CustomLoader(); // Loading until the role is fetched
        }

        switch (profileController.rxRequestStatus.value) {
          case Status.loading:
            return const CustomLoader();

          case Status.internetError:
            return NoInternetScreen(onTap: () {
              if (role.value == 'player') {
                profileController.getPlayerProfile();
              } else if (role.value == 'team') {
                profileController.getTeamProfile();
              }
            });

          case Status.error:
            return GeneralErrorScreen(onTap: () {
              if (role.value == 'player') {
                profileController.getPlayerProfile();
              } else if (role.value == 'team') {
                profileController.getTeamProfile();
              }
            });

          case Status.completed:
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ///===========================Header=================
                    PlayerHomeAppBar(
                      scaffoldKey: scaffoldKey,
                    ),
                    SizedBox(height: 12.h),

                    ///===========================Withdraw=================
                    PlayerHeaderCard(
                      totalAmount: role.value == 'player'
                          ? profileController
                          .playerGetProfileData.value.totalTips
                          .toString()
                          : profileController
                          .teamGetProfileData.value.totalTips
                          .toString(),
                      currentAmount: role.value == 'player'
                          ? profileController
                          .playerGetProfileData.value.dueAmount
                          .toString()
                          : profileController
                          .teamGetProfileData.value.dueAmount
                          .toString(),
                      onTap: () {
                        Get.toNamed(AppRoute.withdrawScreen);
                      },
                    ),
                    SizedBox(height: 12.h),

                    ///===========================Dynamic Name=================
                    if (role.value == 'player')
                      PlayerInfoRow(
                        label: AppStrings.playerName,
                        value: profileController
                            .playerGetProfileData.value.name ??
                            '',
                      )
                    else if (role.value == 'team')
                      PlayerInfoRow(
                        label: AppStrings.teamName,
                        value: profileController
                            .teamGetProfileData.value.name ??
                            '',
                      ),
                    SizedBox(height: 12.h),

                    ///===========================Dynamic Address=================
                    AddressSection(
                      address: role.value == 'player'
                          ? profileController.playerGetProfileData.value.address
                          ?.streetAddress ??
                          ''
                          : profileController.teamGetProfileData.value.address
                          ?.streetAddress ??
                          '',
                      onTap: () {
                        Get.toNamed(AppRoute.addressEdit,arguments: role.value);
                      },
                    ),
                    SizedBox(height: 12.h),

                    ///===========================Tippz History=================
                    const NavigationTile(
                      title: AppStrings.tippzHistory,
                      route: AppRoute.playerTippzHistory,
                    ),
                    SizedBox(height: 12.h),

                    ///===========================Tax Information=================
                    const NavigationTile(
                      title: AppStrings.taxInformation,
                      route: AppRoute.taxInformation,
                    ),
                  ],
                ),
              ),
            );

          default:
            return const SizedBox.shrink();
        }
      }),
    );
  }
}
