import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:protippz/app/controller/player_tippz_history_controller.dart';
import 'package:protippz/app/data/services/app_url.dart';
import 'package:protippz/app/global/helper/date_converter/date_converter.dart';
import 'package:protippz/app/global/widgets/custom_appbar/custom_appbar.dart';
import 'package:protippz/app/global/widgets/custom_loader/custom_loader.dart';
import 'package:protippz/app/global/widgets/genarel_error/genarel_error.dart';
import 'package:protippz/app/player_screen/player_tippz_history/inner_widgets/tippz_history_item.dart';
import 'package:protippz/app/screens/no_internet_screen/no_internet_screen.dart';
import 'package:protippz/app/utils/app_colors.dart';
import 'package:protippz/app/utils/app_constants.dart';
import 'package:protippz/app/utils/app_strings.dart';

class PlayerTippzHistory extends StatelessWidget {
  PlayerTippzHistory({super.key});

  final PlayerTippzHistoryController controller =
  Get.find<PlayerTippzHistoryController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg500,
      appBar: const CustomAppBar(
        appBarContent: AppStrings.tippzHistory,
        iconData: Icons.arrow_back,
      ),
      body: Obx(() {
        switch (controller.rxRequestStatus.value) {
          case Status.loading:
            return const CustomLoader(); // Show loading indicator

          case Status.internetError:
            return NoInternetScreen(onTap: () {
              controller.getPlayerTippzHistory();
            });

          case Status.error:
            return GeneralErrorScreen(
              onTap: () {
                controller.getPlayerTippzHistory();
              },
            );

          case Status.completed:
            return ListView.builder(
              itemCount: controller.tippzHistoryData.value.result?.length,
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              itemBuilder: (context, index) {
                final data = controller.tippzHistoryData.value.result?[index];

                // Fix for imageUrl logic
                String imageUrl =
                (data?.user?.profileImage?.isEmpty ?? true)
                    ? AppConstants.profileImage
                    : "${ApiUrl.netWorkUrl}${data?.user?.profileImage ?? ""}";

                return TippzHistoryItem(
                  imageUrl: imageUrl,
                  amount: "\$${data!.amount.toString()}",
                  date: DateConverter.formatDate(data.createdAt),
                  name: data.user?.name ?? "",
                );
              },
            );
        }
      }),
    );
  }
}
