import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:protippz/app/core/app_routes.dart';
import 'package:protippz/app/core/custom_assets/assets.gen.dart';
import 'package:protippz/app/global/helper/local_db/local_db.dart';
import 'package:protippz/app/utils/app_colors.dart';
import 'package:protippz/app/utils/app_constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  navigate() async {
    await Future.delayed(const Duration(seconds: 2));

    final token = await SharePrefsHelper.getString(AppConstants.bearerToken);
    final role  = await SharePrefsHelper.getString(AppConstants.role);

    if (token.isEmpty) {
      Get.offAllNamed(AppRoute.signInScreen);
      return;
    }

    // Token exists — route by saved role
    if (role == 'team' || role == 'player') {
      Get.offAllNamed(AppRoute.playerHomeScreen);
    } else {
      // 'user' or anything else
      Get.offAllNamed(AppRoute.homeScreen);
    }
  }

  @override
  void initState() {
    super.initState();
    navigate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white50,
      body: Center(
        child: Assets.images.logo.image(),
      ),
    );
  }
}