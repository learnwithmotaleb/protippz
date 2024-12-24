import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:protippz/app/core/app_routes.dart';
import 'package:protippz/app/player_screen/player_home_screen/inner_widgets/player_side_drawer.dart';
import 'package:protippz/app/screens/home_screen/inner_widgets/home_app_bar.dart';
import 'package:protippz/app/screens/home_screen/inner_widgets/side_drawer.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: const PlayerSideDrawer(),
      backgroundColor: AppColors.bg500,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ///===========================Header=================

            SizedBox(height: 12.h),

            ///===========================Sign In Button=================
            PlayerHeaderCard(
              totalAmount: '\$2550',
              currentAmount: '\$550',
              onTap: () {},
            ),
            SizedBox(height: 12.h),

            ///===========================Player Name=================
            const PlayerInfoRow(
              label: AppStrings.playerName,
              value: 'Robert Smith',
            ),
            SizedBox(height: 12.h),

            ///===========================Team Name=================
            const PlayerInfoRow(
              label: AppStrings.teamName,
              value: 'New York Liberty',
            ),
            SizedBox(height: 12.h),

            ///===========================Address Section=================
            const AddressSection(
              address: '1901 Thornridge Cir. Shiloh, Hawaii 81063, New York',
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
  }
}
