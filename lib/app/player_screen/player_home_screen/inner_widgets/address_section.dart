import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:protippz/app/core/app_routes.dart';
import 'package:protippz/app/core/custom_assets/assets.gen.dart';
import 'package:protippz/app/global/widgets/custom_text/custom_text.dart';
import 'package:protippz/app/utils/app_colors.dart';
import 'package:protippz/app/utils/app_strings.dart';

class AddressSection extends StatelessWidget {
  const AddressSection(
      {super.key,
      required this.address,
      required this.onTap,
      required this.title});

  final String address;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white50,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
               CustomText(
                text: title,
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: AppColors.blue500,
              ),
              GestureDetector(
                onTap: onTap,
                child: Assets.icons.edit.svg(),
              ),
            ],
          ),
          CustomText(
            top: 12,
            textAlign: TextAlign.start,
            maxLines: 10,
            text: address,
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: AppColors.green500,
          ),
        ],
      ),
    );
  }
}
