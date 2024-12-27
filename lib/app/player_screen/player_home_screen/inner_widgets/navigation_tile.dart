
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:protippz/app/global/widgets/custom_text/custom_text.dart';
import 'package:protippz/app/utils/app_colors.dart';

class NavigationTile extends StatelessWidget {
  final String title;
  final String route;

  const NavigationTile({super.key, required this.title, required this.route});



  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(route);
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white50,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              text: title,
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: AppColors.blue500,
            ),
            const Icon(
              Icons.keyboard_arrow_right,
              color: AppColors.green500,
            ),
          ],
        ),
      ),
    );
  }
}
