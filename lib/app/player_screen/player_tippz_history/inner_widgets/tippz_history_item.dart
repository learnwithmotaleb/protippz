import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:protippz/app/global/widgets/custom_network_image/custom_network_image.dart';
import 'package:protippz/app/global/widgets/custom_text/custom_text.dart';
import 'package:protippz/app/utils/app_colors.dart';

class TippzHistoryItem extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String amount;
  final String date;

  const TippzHistoryItem({super.key,
    required this.imageUrl,
    required this.name,
    required this.amount,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomNetworkImage(
            boxShape: BoxShape.circle,
            imageUrl: imageUrl,
            height: 48.w, // Adjusted for responsiveness
            width: 48.w,
          ),
          SizedBox(width: 15.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: CustomText(
                        textAlign: TextAlign.start,
                        text: name,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.gray500,
                        bottom: 4.h,
                      ),
                    ),
                    CustomText(
                      text: amount,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.gray500,
                      bottom: 4.h,
                    ),
                  ],
                ),
                CustomText(
                  text: date,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.grey400,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}