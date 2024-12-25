import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:protippz/app/global/widgets/custom_button/custom_button.dart';
import 'package:protippz/app/global/widgets/custom_text/custom_text.dart';
import 'package:protippz/app/utils/app_colors.dart';
import 'package:protippz/app/utils/app_strings.dart';

class PlayerHeaderCard extends StatelessWidget {
  const PlayerHeaderCard({super.key, required this.totalAmount, required this.currentAmount, required this.onTap});

  final String totalAmount;
  final String currentAmount;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: AppColors.white50,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                 _StatCard(
                  title: AppStrings.totalTippz,
                  value: totalAmount,
                ),
                SizedBox(width: 12.h),
                 _StatCard(
                  title: AppStrings.currentBalance,
                  value: currentAmount,
                ),
              ],
            ),
          ),
          SizedBox(height: 12.h),
          CustomButton(
            onTap:onTap,
            fillColor: AppColors.blue500,
            title: AppStrings.withdrawNow,
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;

  const _StatCard({
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
      decoration: BoxDecoration(
        color: AppColors.bg500,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          CustomText(
            text: title,
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: AppColors.green500,
          ),
          CustomText(
            top: 8,
            text: value,
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: AppColors.blue500,
          ),
        ],
      ),
    );
  }
}