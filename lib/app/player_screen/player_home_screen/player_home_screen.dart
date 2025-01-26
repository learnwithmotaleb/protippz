import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:protippz/app/controller/email_add_controller.dart';
import 'package:protippz/app/controller/player_tippz_history_controller.dart';
import 'package:protippz/app/core/app_routes.dart';
import 'package:protippz/app/global/helper/local_db/local_db.dart';
import 'package:protippz/app/global/widgets/custom_button/custom_button.dart';
import 'package:protippz/app/global/widgets/custom_from_card/custom_from_card.dart';
import 'package:protippz/app/global/widgets/custom_loader/custom_loader.dart';
import 'package:protippz/app/global/widgets/genarel_error/genarel_error.dart';
import 'package:protippz/app/global/widgets/toast_message/toast_message.dart';
import 'package:protippz/app/player_screen/player_home_screen/inner_widgets/player_home_app_bar.dart';
import 'package:protippz/app/player_screen/player_home_screen/inner_widgets/player_side_drawer.dart';
import 'package:protippz/app/screens/no_internet_screen/no_internet_screen.dart';
import 'package:protippz/app/utils/app_colors.dart';
import 'package:protippz/app/utils/app_constants.dart';
import 'package:protippz/app/utils/app_strings.dart';

import 'inner_widgets/address_section.dart';
import 'inner_widgets/navigation_tile.dart';
import 'inner_widgets/player_header_card.dart';
import 'inner_widgets/player_info_row.dart';

class PlayerHomeScreen extends StatefulWidget {
  const PlayerHomeScreen({super.key});

  @override
  _PlayerHomeScreenState createState() => _PlayerHomeScreenState();
}

class _PlayerHomeScreenState extends State<PlayerHomeScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final PlayerTippzHistoryController profileController = Get.find<
      PlayerTippzHistoryController>();
  final RxString role = ''.obs;

  @override
  void initState() {
    super.initState();
    checkSavedRole();
  }

  Future<void> checkSavedRole() async {
    role.value = await SharePrefsHelper.getString(AppConstants.role) ?? '';

    if (role.value == 'player') {
      await profileController.getPlayerProfile();
    } else if (role.value == 'team') {
      await profileController.getTeamProfile();
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final user = profileController.teamGetProfileData.value.user;
      final email = user?.email;

      if (email == null || email.isEmpty) {
        showEmailDialog();
      } else {
        toastMessage(message: 'Email is not empty');
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: const PlayerSideDrawer(),
      backgroundColor: AppColors.bg500,
      body: Obx(() {
        if (role.value.isEmpty) {
          return const CustomLoader(); // Loading until the role is fetched
        }

        switch (profileController.rxRequestStatus.value) {
          case Status.loading:
            return const CustomLoader();

          case Status.internetError:
            return NoInternetScreen(onTap: () => _retryFetchProfile());

          case Status.error:
            return GeneralErrorScreen(onTap: () => _retryFetchProfile());

          case Status.completed:
            return _buildProfileContent();

          default:
            return const SizedBox.shrink();
        }
      }),
    );
  }

  void _retryFetchProfile() {
    if (role.value == 'player') {
      profileController.getPlayerProfile();
    } else if (role.value == 'team') {
      profileController.getTeamProfile();
    }
  }

  Widget _buildProfileContent() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            PlayerHomeAppBar(scaffoldKey: scaffoldKey),
            SizedBox(height: 12.h),
            //===========================Header=======================
            PlayerHeaderCard(
              totalAmount: role.value == 'player'
                  ? profileController.playerGetProfileData.value.totalTips
                  .toString()
                  : profileController.teamGetProfileData.value.totalTips
                  .toString(),
              currentAmount: role.value == 'player'
                  ? profileController.playerGetProfileData.value.dueAmount
                  .toString()
                  : profileController.teamGetProfileData.value.dueAmount
                  .toString(),
              onTap: () => Get.toNamed(AppRoute.withdrawScreen),
            ),
            SizedBox(height: 12.h),
            //===========================Name=======================
            _buildDynamicName(),
            SizedBox(height: 12.h),
            //===========================Address=======================
            _buildAddressSection(),
            SizedBox(height: 12.h),
            //===========================tippzHistory=======================
            _buildNavigationTile(
                AppStrings.tippzHistory, AppRoute.playerTippzHistory),
            SizedBox(height: 12.h),
            //===========================taxInformation=======================
            // _buildNavigationTile(
            //     AppStrings.taxInformation, AppRoute.taxInformation,
            //     arguments: role.value),

            _buildTextSection()
          ],
        ),
      ),
    );
  }

  Widget _buildDynamicName() {
    return PlayerInfoRow(
      label: role.value == 'player' ? AppStrings.playerName : AppStrings
          .teamName,
      value: role.value == 'player'
          ? profileController.playerGetProfileData.value.name ?? ''
          : profileController.teamGetProfileData.value.name ?? '',
    );
  }

  Widget _buildAddressSection() {
    return AddressSection(
      address: role.value == 'player'
          ? '${profileController.playerGetProfileData.value.address?.streetAddress ?? ''} '
          '${profileController.playerGetProfileData.value.address?.city ?? ''} '
          '${profileController.playerGetProfileData.value.address?.state ?? ''} '
          '${profileController.playerGetProfileData.value.address?.zipCode ?? ''}'
          : '${profileController.teamGetProfileData.value.address?.streetAddress ?? ''} '
          '${profileController.teamGetProfileData.value.address?.city ?? ''} '
          '${profileController.teamGetProfileData.value.address?.state ?? ''} '
          '${profileController.teamGetProfileData.value.address?.zipCode ?? ''}',
      onTap: () => Get.toNamed(AppRoute.addressEdit, arguments: role.value), title: AppStrings.addressColon,
    );
  }

  Widget _buildTextSection() {
    return AddressSection(
      address: role.value == 'player'
          ? '${profileController.playerGetProfileData.value.taxInfo?.address ?? ''} '
          '${profileController.playerGetProfileData.value.taxInfo?.fullname ?? ''} '
          '${profileController.playerGetProfileData.value.taxInfo?.taxId ?? ''} '
          : '${profileController.teamGetProfileData.value.taxInfo?.address ?? ''} '
          '${profileController.teamGetProfileData.value.taxInfo?.fullname ?? ''} '
          '${profileController.teamGetProfileData.value.taxInfo?.taxId ?? ''} ',
      onTap: () => Get.toNamed(AppRoute.taxInformation, arguments: role.value), title: AppStrings.taxInformation,
    );
  }


  Widget _buildNavigationTile(String title, String route, {dynamic arguments}) {
    return NavigationTile(
      title: title,
      onTap: () => Get.toNamed(route, arguments: arguments),
    );
  }

  void showEmailDialog() {
    final EmailAddController controller = Get.find<EmailAddController>();
    final formKey = GlobalKey<FormState>();

    Get.defaultDialog(
      backgroundColor: Colors.blueGrey,
      title: 'Enter Your Email',
      content: Obx(() {
        return Form(
          key: formKey,
          child: Column(
            children: [
              CustomFromCard(
                title: AppStrings.enterYourEmail,
                controller: controller.emailController,
                validator: (value) {
                  if (value!.isEmpty ||
                      !AppStrings.emailRegexp.hasMatch(value)) {
                    return AppStrings.enterValidEmail;
                  }
                  return null;
                },
              ),
              SizedBox(height: 15.h),
              controller.isAddEmail.value
                  ? const CustomLoader()
                  : CustomButton(
                onTap: () {
                  if (formKey.currentState!.validate()) {
                    controller.addEmail();
                    Get.back();
                    showOtpDialog();
                  }
                },
                title: AppStrings.verify,
              ),
            ],
          ),
        );
      }),
    );
  }

  void showOtpDialog() {
    final EmailAddController controller = Get.find<EmailAddController>();
    final formKey = GlobalKey<FormState>();

    Get.defaultDialog(
      backgroundColor: Colors.blueGrey,
      title: 'Enter Code',
      content: Obx(() {
        return Form(
          key: formKey,
          child: Column(
            children: [
              PinCodeTextField(
                textStyle: const TextStyle(color: AppColors.gray500),
                keyboardType: TextInputType.phone,
                cursorColor: AppColors.gray500,
                appContext: context,
                controller: controller.pinCodeController,
                onCompleted: (value) {
                  controller.activationCode = value;
                },
                validator: (value) {
                  if (value != null && value.length == 5) {
                    return null;
                  }
                  return "Please enter a valid 5-digit OTP code";
                },
                autoFocus: true,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(12),
                  fieldHeight: 49.h,
                  fieldWidth: 47,
                  activeFillColor: AppColors.white50,
                  selectedFillColor: AppColors.white50,
                  inactiveFillColor: AppColors.white50,
                  borderWidth: 0.5,
                  activeBorderWidth: 0.8,
                  activeColor: AppColors.white50,
                ),
                length: 5,
                enableActiveFill: true,
              ),
              SizedBox(height: 15.h),
              controller.isAddEmail.value
                  ? const CustomLoader()
                  : CustomButton(
                onTap: () {
                  Get.back();
                  if (formKey.currentState!.validate()) {
                    controller.addEmailVerify();
                  }
                },
                title: AppStrings.verifyCode,
              ),
            ],
          ),
        );
      }),
    );
  }
}