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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CustomAppBar(
        title: LabelString.labelBookEms,
        isNotification: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.sp),
        child: Center(
          child: CustomButton(
            onPressed: () {
              showDialog(context: context, builder: (context) => const AmbulanceCallDialog());
            },
            text: "Book Ambulance",
          ),
        ),
      ),
    );
  }
}

class AmbulanceCallDialog extends StatefulWidget {
  const AmbulanceCallDialog({Key? key}) : super(key: key);

  @override
  State<AmbulanceCallDialog> createState() => _AmbulanceCallDialogState();
}

class _AmbulanceCallDialogState extends State<AmbulanceCallDialog> {
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
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.sp)),
      backgroundColor: AppColors.greyBg,
      insetPadding: EdgeInsets.symmetric(horizontal: 18.sp),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          15.verticalSpace,
          Text(
            LabelString.labelCallEms,
            style: GoogleFonts.dmSans(fontSize: 18.sp, fontWeight: FontWeight.w600, color: AppColors.blackColor),
            textAlign: TextAlign.center,
          ),
          18.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  isForSelf.value = true;
                  isForOthers.value = false;
                },
                child: Column(
                  children: [
                    Stack(
                      children: [
                        ValueListenableBuilder<bool>(
                          valueListenable: isForSelf,
                          builder: (context, value, child) {
                            return Container(
                              width: 90.sp,
                              height: 90.sp,
                              decoration: BoxDecoration(color: value ? AppColors.redColor : AppColors.whiteColor, shape: BoxShape.circle),
                              padding: EdgeInsets.all(20.sp),
                              child: Assets.icIcons.single.svg(
                                colorFilter: ColorFilter.mode(value ? AppColors.whiteColor : AppColors.blackColor, BlendMode.srcIn),
                              ),
                            );
                          },
                        ),
                        ValueListenableBuilder<bool>(
                          valueListenable: isForSelf,
                          builder: (context, value, child) {
                            return value
                                ? Positioned(
                                  right: 0,
                                  bottom: 0,
                                  child: Container(
                                    width: 24.sp,
                                    height: 24.sp,
                                    decoration: BoxDecoration(
                                      color: AppColors.blueColor,
                                      shape: BoxShape.circle,
                                      border: Border.all(color: AppColors.greyBg, width: 2),
                                    ),
                                    child: Icon(Icons.check, color: Colors.white, size: 16.sp),
                                  ),
                                )
                                : const SizedBox.shrink();
                          },
                        ),
                      ],
                    ),
                    12.verticalSpace,
                    Text(
                      LabelString.labelYourself,
                      style: GoogleFonts.dmSans(fontSize: 16.sp, fontWeight: FontWeight.w500, color: AppColors.blackColor),
                    ),
                  ],
                ),
              ),
              50.horizontalSpace,
              GestureDetector(
                onTap: () {
                  isForSelf.value = false;
                  isForOthers.value = true;
                },
                child: Column(
                  children: [
                    Stack(
                      children: [
                        ValueListenableBuilder<bool>(
                          valueListenable: isForOthers,
                          builder: (context, value, child) {
                            return Container(
                              width: 90.sp,
                              height: 90.sp,
                              decoration: BoxDecoration(color: value ? AppColors.redColor : AppColors.whiteColor, shape: BoxShape.circle),
                              padding: EdgeInsets.all(20.sp),
                              child: Assets.icIcons.group.svg(
                                colorFilter: ColorFilter.mode(value ? AppColors.whiteColor : AppColors.blackColor, BlendMode.srcIn),
                              ),
                            );
                          },
                        ),
                        ValueListenableBuilder<bool>(
                          valueListenable: isForOthers,
                          builder: (context, value, child) {
                            return value
                                ? Positioned(
                                  right: 0,
                                  bottom: 0,
                                  child: Container(
                                    width: 24.sp,
                                    height: 24.sp,
                                    decoration: BoxDecoration(
                                      color: AppColors.blueColor,
                                      shape: BoxShape.circle,
                                      border: Border.all(color: AppColors.greyBg, width: 2),
                                    ),
                                    child: Icon(Icons.check, color: Colors.white, size: 16.sp),
                                  ),
                                )
                                : const SizedBox.shrink();
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      LabelString.labelOthers,
                      style: GoogleFonts.dmSans(fontSize: 16.sp, fontWeight: FontWeight.w500, color: AppColors.blackColor),
                    ),
                  ],
                ),
              ),
            ],
          ),
          15.verticalSpace,
          CustomButton(
            width: context.width() * 0.7,
            onPressed: () {
              navigationService.pop();
              navigationService.push(PtConfirmLocationPage());
            },
            text: LabelString.labelNext,
          ),
          15.verticalSpace,
          Padding(
            padding: EdgeInsets.only(bottom: 14.sp),
            child: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Container(
                width: 50.sp,
                height: 50.sp,
                padding: EdgeInsets.all(15.sp),
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  shape: BoxShape.circle,
                  boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 10, offset: Offset(0, 4))],
                ),
                child: Assets.icIcons.close.svg(colorFilter: ColorFilter.mode(AppColors.redColor, BlendMode.srcIn)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
