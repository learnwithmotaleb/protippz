import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:protippz/app/core/custom_assets/assets.gen.dart';
import 'package:protippz/app/utils/app_colors.dart';

class PlayerHomeAppBar extends StatelessWidget {
  const PlayerHomeAppBar({
    super.key,
    required this.scaffoldKey,
    required this.name,
    required this.image,
  });

  final String name;
  final String image;
  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: AppColors.white50,
      margin: EdgeInsets.only(
        top: 32.h,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ///====================================Top Section================================
          SizedBox(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Assets.images.logo.image(
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width / 2),

                ///==========================Drawer button ====================
                GestureDetector(
                    onTap: () {
                      scaffoldKey.currentState?.openDrawer();
                    },
                    child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          color: AppColors.green500,
                          shape: BoxShape.circle,
                        ),
                        child: Assets.icons.drawer.svg(
                          colorFilter: const ColorFilter.mode(
                              AppColors.white50, BlendMode.srcIn),
                        )))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
