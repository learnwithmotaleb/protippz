import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:protippz/app/controller/info_controller.dart';
import 'package:protippz/app/global/widgets/custom_appbar/custom_appbar.dart';
import 'package:protippz/app/global/widgets/custom_loader/custom_loader.dart';
import 'package:protippz/app/global/widgets/genarel_error/genarel_error.dart';
import 'package:protippz/app/screens/no_internet_screen/no_internet_screen.dart';
import 'package:protippz/app/utils/app_colors.dart';
import 'package:protippz/app/utils/app_constants.dart';
import 'package:protippz/app/utils/app_strings.dart';

class TermsConditionScreen extends StatefulWidget {
  TermsConditionScreen({super.key});

  @override
  State<TermsConditionScreen> createState() => _TermsConditionScreenState();
}

class _TermsConditionScreenState extends State<TermsConditionScreen> {
  final InfoController infoController = Get.find<InfoController>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      infoController.getTerms();
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg500,
      appBar: const CustomAppBar(
        appBarContent: AppStrings.termsAndCondition,
        iconData: Icons.arrow_back,
      ),
      body: Obx(() {
        switch (infoController.rxRequestStatus.value) {
          case Status.loading:
            return const CustomLoader();

          case Status.internetError:
            return NoInternetScreen(onTap: () {
              infoController.getTerms();
            });

          case Status.error:
            return GeneralErrorScreen(onTap: () {
              infoController.getTerms();
            });

          case Status.completed:
            final descriptions = infoController.termsModel.value.description??"";
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 20.w),
              child:
              HtmlWidget(
                descriptions ?? "No description available.",

              ),
            );

          default:
            return const SizedBox();
        }
      }),
    );
  }
}
