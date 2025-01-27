import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:protippz/app/controller/player_tippz_history_controller.dart';
import 'package:protippz/app/core/app_routes.dart';
import 'package:protippz/app/global/helper/local_db/local_db.dart';
import 'package:protippz/app/global/widgets/custom_loader/custom_loader.dart';
import 'package:protippz/app/global/widgets/genarel_error/genarel_error.dart';
import 'package:protippz/app/screens/no_internet_screen/no_internet_screen.dart';
import 'package:protippz/app/utils/app_colors.dart';
import 'package:protippz/app/utils/app_constants.dart';
import 'package:protippz/app/utils/app_strings.dart';
import 'inner_widgets/address_section.dart';
import 'inner_widgets/player_header_card.dart';
import 'inner_widgets/player_info_row.dart';
import 'inner_widgets/player_home_app_bar.dart';
import 'inner_widgets/player_side_drawer.dart';
import 'inner_widgets/navigation_tile.dart';

class PlayerHomeScreen extends StatefulWidget {
  const PlayerHomeScreen({super.key});

  @override
  _PlayerHomeScreenState createState() => _PlayerHomeScreenState();
}

class _PlayerHomeScreenState extends State<PlayerHomeScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final PlayerTippzHistoryController profileController = Get.find<PlayerTippzHistoryController>();
  final RxString role = ''.obs;

  @override
  void initState() {
    super.initState();
    _fetchInitialData();
  }

  Future<void> _fetchInitialData() async {
    role.value = await SharePrefsHelper.getString(AppConstants.role) ?? '';
    _retryFetchProfile();
  }

  Future<void> _retryFetchProfile() async {
    if (role.value == 'player') {
      await profileController.getPlayerProfile();
    } else if (role.value == 'team') {
      await profileController.getTeamProfile();
    }
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
            return NoInternetScreen(onTap: _retryFetchProfile);

          case Status.error:
            return GeneralErrorScreen(onTap: _retryFetchProfile);

          case Status.completed:
            return RefreshIndicator(
              onRefresh: _retryFetchProfile,
              child: _buildProfileContent(),
            );

          default:
            return const SizedBox.shrink();
        }
      }),
    );
  }

  Widget _buildProfileContent() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(), // Enables pull-to-refresh
        child: Column(
          children: [
            PlayerHomeAppBar(scaffoldKey: scaffoldKey),
            SizedBox(height: 12.h),
            PlayerHeaderCard(
              totalAmount: role.value == 'player'
                  ? profileController.playerGetProfileData.value.totalTips.toString()
                  : profileController.teamGetProfileData.value.totalTips.toString(),
              currentAmount: role.value == 'player'
                  ? profileController.playerGetProfileData.value.dueAmount.toString()
                  : profileController.teamGetProfileData.value.dueAmount.toString(),
              onTap: () => Get.toNamed(AppRoute.withdrawScreen),
            ),
            SizedBox(height: 12.h),
            _buildDynamicName(),
            SizedBox(height: 12.h),
            _buildAddressSection(),
            SizedBox(height: 12.h),
            _buildNavigationTile(AppStrings.tippzHistory, AppRoute.playerTippzHistory),
            SizedBox(height: 12.h),
            _buildTextSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildDynamicName() {
    return PlayerInfoRow(
      label: role.value == 'player' ? AppStrings.playerName : AppStrings.teamName,
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
      onTap: () => Get.toNamed(AppRoute.addressEdit, arguments: role.value),
      title: AppStrings.addressColon,
    );
  }

  Widget _buildTextSection() {
    return AddressSection(
      address: role.value == 'player'
          ? '${profileController.playerGetProfileData.value.taxInfo?.address ?? ''} '
          '${profileController.playerGetProfileData.value.taxInfo?.fullname ?? ''} '
          '${profileController.playerGetProfileData.value.taxInfo?.taxId ?? ''}'
          : '${profileController.teamGetProfileData.value.taxInfo?.address ?? ''} '
          '${profileController.teamGetProfileData.value.taxInfo?.fullname ?? ''} '
          '${profileController.teamGetProfileData.value.taxInfo?.taxId ?? ''}',
      onTap: () => Get.toNamed(AppRoute.taxInformation, arguments: role.value),
      title: AppStrings.taxInformation,
    );
  }

  Widget _buildNavigationTile(String title, String route, {dynamic arguments}) {
    return NavigationTile(
      title: title,
      onTap: () => Get.toNamed(route, arguments: arguments),
    );
  }
}
