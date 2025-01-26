import 'package:flutter/material.dart';
import 'package:protippz/app/global/widgets/custom_text/custom_text.dart';
import 'package:protippz/app/utils/app_colors.dart';

class PlayerInfoRow extends StatelessWidget {
  final String label;
  final String value;

  const PlayerInfoRow({super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white50,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            text: label,
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: AppColors.blue500,
          ),
          Expanded(
            child: CustomText(
              maxLines: 5,
              text: value,
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppColors.green500,
            ),
          ),
        ],
      ),
    );
  }
}