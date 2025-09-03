import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medizii/components/context_extension.dart';
import 'package:medizii/components/custom_appbar.dart';
import 'package:medizii/components/custom_button.dart';
import 'package:medizii/constants/app_colours/app_colors.dart';
import 'package:medizii/constants/strings.dart';
import 'package:medizii/gen/assets.gen.dart';
import 'package:medizii/main.dart';

import 'pt_confirm_location_pg.dart';

class PatientBookEmsPage extends StatefulWidget {
  const PatientBookEmsPage({super.key});

  @override
  State<PatientBookEmsPage> createState() => _PatientBookEmsPageState();
}

class _PatientBookEmsPageState extends State<PatientBookEmsPage> {
  String selectedOption = 'Others'; // Default selection
  final ValueNotifier<bool> isForSelf = ValueNotifier<bool>(false);
  final ValueNotifier<bool> isForOthers = ValueNotifier<bool>(true);

  @override
  void dispose() {
    isForSelf.dispose();
    isForOthers.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CustomAppBar(
        title: LabelString.labelCallEms,
        isNotification: false,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.sp),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          15.verticalSpace,
          GestureDetector(
            onTap: () {
              isForSelf.value = true;
              isForOthers.value = false;
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 14.sp, vertical: 14.sp),
              decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(14.r)),
              child: Row(
                children: [
                  ValueListenableBuilder<bool>(
                    valueListenable: isForSelf,
                    builder: (context, value, child) {
                      return Container(
                        width: 35.sp,
                        height: 35.sp,
                        decoration: BoxDecoration(color: value ? AppColors.redColor : AppColors.greyBg, shape: BoxShape.circle),
                        padding: EdgeInsets.all(5.sp),
                        child: Assets.icIcons.single.svg(
                          colorFilter: ColorFilter.mode(value ? AppColors.whiteColor : AppColors.blackColor, BlendMode.srcIn),
                        ),
                      );
                    },
                  ),
                  20.horizontalSpace,
                  Text(
                    LabelString.labelYourself,
                    style: GoogleFonts.dmSans(fontSize: 16.sp, fontWeight: FontWeight.w500, color: AppColors.blackColor),
                  ),
                  Spacer(),
                  ValueListenableBuilder<bool>(
                    valueListenable: isForSelf,
                    builder: (context, value, child) {
                      return value
                          ? Container(
                        width: 20.sp,
                        height: 20.sp,
                        decoration: BoxDecoration(
                          color: AppColors.blueColor,
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.greyBg, width: 2),
                        ),
                        child: Icon(Icons.check, color: Colors.white, size: 16.sp),
                      )
                          : const SizedBox.shrink();
                    },
                  ),
                ],
              ),
            ),
          ),
          15.verticalSpace,
          GestureDetector(
            onTap: () {
              isForSelf.value = false;
              isForOthers.value = true;
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 14.sp, vertical: 14.sp),
              decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(14.r)),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ValueListenableBuilder<bool>(
                    valueListenable: isForOthers,
                    builder: (context, value, child) {
                      return Container(
                        width: 35.sp,
                        height: 35.sp,
                        decoration: BoxDecoration(color: value ? AppColors.redColor : AppColors.greyBg, shape: BoxShape.circle),
                        padding: EdgeInsets.all(5.sp),
                        child: Assets.icIcons.group.svg(
                          colorFilter: ColorFilter.mode(value ? AppColors.whiteColor : AppColors.blackColor, BlendMode.srcIn),
                        ),
                      );
                    },
                  ),
                  20.horizontalSpace,
                  Text(
                    LabelString.labelOthers,
                    style: GoogleFonts.dmSans(fontSize: 16.sp, fontWeight: FontWeight.w500, color: AppColors.blackColor),
                  ),
                  Spacer(),
                  ValueListenableBuilder<bool>(
                    valueListenable: isForOthers,
                    builder: (context, value, child) {
                      return value
                          ? Container(
                        width: 20.sp,
                        height: 20.sp,
                        decoration: BoxDecoration(
                          color: AppColors.blueColor,
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.greyBg, width: 2),
                        ),
                        child: Icon(Icons.check, color: Colors.white, size: 16.sp),
                      )
                          : const SizedBox.shrink();
                    },
                  ),
                ],
              ),
            ),
          ),
          Spacer(),
          CustomButton(
            width: context.width() * 0.7,
            onPressed: () {
              navigationService.pop();
              navigationService.push(PtConfirmLocationPage());
            },
            text: LabelString.labelNext,
          ),
        ],
        ),
      ),
    );
  }
}
