import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:protippz/app/core/custom_assets/assets.gen.dart';
import 'package:protippz/app/global/widgets/custom_button/custom_button.dart';
import 'package:protippz/app/global/widgets/custom_text/custom_text.dart';
import 'package:protippz/app/utils/app_colors.dart';
import 'package:protippz/app/utils/app_strings.dart';
import 'package:get/get.dart';

class CustomPlayerCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String? team;
  final String? position;
  final VoidCallback onTap;
  final VoidCallback onBookMarkTab;
  final RxBool isBookmark;

  const CustomPlayerCard({
    super.key,
    required this.imageUrl,
    required this.name,
    this.team,
    this.position,
    required this.onTap,
    required this.onBookMarkTab,
    required this.isBookmark,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double width = constraints.maxWidth; // Get the width of the available space
        double height = constraints.maxHeight; // Get the height of the available space

        return Container(
          // width: width * 0.45, // Adjust width dynamically
          // height: height * 0.55, // Adjust height dynamically
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.9),
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(color: AppColors.green500),
            image: DecorationImage(
              image: AssetImage(Assets.images.playerz.path),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                    child: CachedNetworkImage(
                      imageUrl: imageUrl,
                      fit: BoxFit.cover,
                      height: height * 0.3, // Dynamic image height
                      width: width * 0.45, // Dynamic image width
                    ),
                  ),
                  Positioned(
                    top: 10, // Adjust this to position the icon above the card
                    right: 1.w, // Adjust for right positioning
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      child: GestureDetector(
                        onTap: onBookMarkTab, // Trigger bookmark action
                        child: Obx(() {
                          return isBookmark.value
                              ? Assets.images.starSelected.image()
                              : Assets.images.startUnselected.image();
                        }),
                      ),
                    ),
                  ),
                ],
              ),
              Gap(8.h),
              Center(
                child: CustomText(
                  text: name,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: AppColors.blue500,
                ),
              ),
              Gap(4.h),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: RichText(
                  textAlign: TextAlign.start,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: AppStrings.team,
                        style: TextStyle(
                          fontSize: 16.h,
                          fontWeight: FontWeight.w400,
                          color: AppColors.green500,
                        ),
                      ),
                      TextSpan(
                        text: team,
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.blue500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Gap(8.h),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: RichText(
                  textAlign: TextAlign.start,
                  text: TextSpan(
                    children: [
                      const TextSpan(
                        text: AppStrings.position,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: AppColors.green500,
                        ),
                      ),
                      TextSpan(
                        text: position,
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.blue500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Gap(10.h),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: CustomButton(
                  fillColor: AppColors.blue500,
                  onTap: onTap,
                  title: AppStrings.sendTippz,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

