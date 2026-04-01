
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:protippz/app/controller/google_auth_controller.dart';
import 'package:protippz/app/core/app_routes.dart';
import 'package:protippz/app/core/custom_assets/assets.gen.dart';
import 'package:protippz/app/global/controllers/auth_controller/auth_controller.dart';
import 'package:protippz/app/global/widgets/custom_appbar/custom_appbar.dart';
import 'package:protippz/app/global/widgets/custom_button/custom_button.dart';
import 'package:protippz/app/global/widgets/custom_from_card/custom_from_card.dart';
import 'package:protippz/app/global/widgets/custom_loader/custom_loader.dart';
import 'package:protippz/app/global/widgets/custom_rich_text/custom_rich_text.dart';
import 'package:protippz/app/global/widgets/custom_sign_in_button/custom_sign_in_button.dart';
import 'package:protippz/app/global/widgets/custom_text/custom_text.dart';
import 'package:protippz/app/utils/app_colors.dart';
import 'package:protippz/app/utils/app_strings.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

  final GoogleAuthController _googleAuthController =
      Get.find<GoogleAuthController>();
  final AuthController authController = Get.find<AuthController>();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg500,

      ///========================Sign In Appbar===================
      appBar: const CustomAppBar(
        iconData: Icons.arrow_back_outlined,
        appBarContent: AppStrings.signIn,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const CustomText(
                  text: AppStrings.helloAgain,
                  fontWeight: FontWeight.w500,
                  fontSize: 22,
                  color: AppColors.blue500,
                  bottom: 10,
                ),

                const CustomText(
                  text: AppStrings.welcomeBackToProtippzSignInto,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: AppColors.green500,
                  bottom: 40,
                  maxLines: 3,
                ),

                ///========================Email Field=====================
                CustomFromCard(
                  hinText: AppStrings.enterYourEmailOrUser,
                  title: AppStrings.userNameOrEmail,
                  controller: authController.emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppStrings
                          .enterValidEmailOrUserName; // General error
                    }

                    if (value.contains('@')) {
                      if (!AppStrings.emailRegexp.hasMatch(value)) {
                        return AppStrings.enterValidEmail;
                      } else {
                        return null;
                      }
                    } else {
                      if (value.length < 4) {
                        return 'UserNameToShort';
                      } else {
                        return null;
                      }
                    }
                  },
                ),

                Gap(12.h),

                ///========================Password Field=====================
                CustomFromCard(
                  hinText: AppStrings.enterYourPassword,
                  title: AppStrings.password,
                  isPassword: true,
                  controller: authController.passwordController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return AppStrings.passwordMustHaveEightWith;
                    } else {
                      return null;
                    }
                  },
                ),

                //==============================Forget========================
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(),
                    TextButton(
                        onPressed: () {
                          Get.toNamed(AppRoute.forgotPasswordScreen);
                        },
                        child: const CustomText(
                          color: AppColors.blue500,
                          text: AppStrings.forgotPasswordd,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        )),
                  ],
                ),

                ///===========================Sign In Button=================
                Gap(30.h),
                Obx(() => authController.isSignInLoading.value
                    ? const CustomLoader()
                    : CustomButton(
                        isRadius: true,
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            authController.signInUser();
                          }
                        },
                        title: AppStrings.signIn,
                      )),

                ///===========================Or=================

                const CustomText(
                  text: AppStrings.or,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  bottom: 10,
                  top: 10,
                ),

                ///======================= Google Auth=====================
                Obx(() => _googleAuthController.isGoogleLogin.value
                    ? const CustomLoader()
                    : CustomSocialSignInButton(
                        iconPath: Assets.icons.googleSignIn.svg(),
                        text: AppStrings.signInGoogle,
                        onTap: () {
                          _googleAuthController.googleSignIn();
                        })),
                Gap(15.h),
                const CustomRichTextLink(
                  firstText: AppStrings.dontHaveAnAccount,
                  linkText: AppStrings.signUp,
                  linkRoute: AppRoute.signUpScreen,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
