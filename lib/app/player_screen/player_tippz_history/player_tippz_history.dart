import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:protippz/app/global/widgets/custom_appbar/custom_appbar.dart';
import 'package:protippz/app/player_screen/player_tippz_history/inner_widgets/tippz_history_item.dart';
import 'package:protippz/app/utils/app_colors.dart';
import 'package:protippz/app/utils/app_constants.dart';
import 'package:protippz/app/utils/app_strings.dart';

class PlayerTippzHistory extends StatelessWidget {
  const PlayerTippzHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg500,
      appBar: const CustomAppBar(
        appBarContent: AppStrings.tippzHistory,
        iconData: Icons.arrow_back,
      ),
      body: ListView.builder(
        itemCount: 4,
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        itemBuilder: (context, index) {
          return TippzHistoryItem(
            imageUrl: AppConstants.profileImage,
            name: 'Cody Fisher',
            amount: '\$25.00',
            date: '12/08/24',
          );
        },
      ),
    );
  }
}





