import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medizii/components/custom_appbar.dart';
import 'package:medizii/components/custom_button.dart';
import 'package:medizii/constants/app_colours/app_colors.dart';
import 'package:medizii/constants/strings.dart';
import 'package:medizii/gen/assets.gen.dart';

class TechnicianRequestAcceptPage extends StatelessWidget {
  const TechnicianRequestAcceptPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "#2123",
        isBack: true,
        rightWidget: Row(
          children: [
            GestureDetector(
              onTap: () {},
              child: Container(
                decoration: BoxDecoration(color: AppColors.greyBg, shape: BoxShape.circle),
                padding: EdgeInsets.all(6.sp),
                child: Assets.icIcons.call.svg(colorFilter: ColorFilter.mode(AppColors.blackColor, BlendMode.srcIn)),
              ),
            ),
            10.horizontalSpace,
            GestureDetector(
              onTap: () {},
              child: Container(
                decoration: BoxDecoration(color: AppColors.greyBg, shape: BoxShape.circle),
                padding: EdgeInsets.all(6.sp),
                child: Assets.icIcons.video.svg(colorFilter: ColorFilter.mode(AppColors.blackColor, BlendMode.srcIn)),
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(18.sp, 8.sp, 18.sp, 10.sp),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(18.sp, 10.sp, 18.sp, 10.sp),
              decoration: BoxDecoration(
                color: AppColors.greyBg,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(color: Colors.grey.withValues(alpha: 0.1), spreadRadius: 2, blurRadius: 10, offset: const Offset(0, 5)),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Assets.icIcons.location1.svg(colorFilter: ColorFilter.mode(AppColors.blueColor, BlendMode.srcIn)),
                          DottedLine(
                            direction: Axis.vertical,
                            lineLength: 0.036.sh,
                            lineThickness: 1.5,
                            dashLength: 6.0,
                            dashColor: Colors.black,
                            dashGapLength: 1.5,
                          ),
                          Assets.icIcons.location.svg(colorFilter: ColorFilter.mode(AppColors.redColor, BlendMode.srcIn)),
                        ],
                      ),
                      12.horizontalSpace,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Pickup
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(LabelString.labelPickupLocation, style: GoogleFonts.dmSans(fontSize: 12.sp, color: AppColors.gray)),
                                Text(LabelString.labelDistance, style: GoogleFonts.dmSans(fontSize: 12.sp, color: AppColors.gray)),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    "96966 Amalia Green, NY",
                                    style: GoogleFonts.dmSans(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                                  ),
                                ),
                                Text(
                                  "12km",
                                  style: GoogleFonts.dmSans(fontSize: 12.sp, fontWeight: FontWeight.bold, color: AppColors.redColor),
                                ),
                              ],
                            ),
                            12.verticalSpace,
                            Text(LabelString.labelDropLocation, style: GoogleFonts.dmSans(fontSize: 12.sp, color: AppColors.gray)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "ABC Hospital",
                                  style: GoogleFonts.dmSans(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                                ),
                                Container(
                                  padding: EdgeInsets.all(8.sp),
                                  decoration: BoxDecoration(color: AppColors.iconBgColor, borderRadius: BorderRadius.circular(25)),
                                  child: Assets.icIcons.location.svg(colorFilter: ColorFilter.mode(AppColors.redColor, BlendMode.srcIn)),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            15.verticalSpace,
            _patientDetailTile("Patient Name", "Roger Siphorn"),
            15.verticalSpace,
            _patientDetailTile("Phone Number", "752-392-7431"),
            15.verticalSpace,
            _patientDetailTile("Pick up Time", "10:30 AM"),
            15.verticalSpace,
            Container(
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(18.sp, 10.sp, 18.sp, 10.sp),
              decoration: BoxDecoration(
                color: AppColors.greyBg,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(color: Colors.grey.withValues(alpha: 0.1), spreadRadius: 2, blurRadius: 10, offset: const Offset(0, 5)),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Reason", style: GoogleFonts.dmSans(fontSize: 14.sp, color: Colors.black54)),
                  5.verticalSpace,
                  CustomButton(height: 35.sp, width: 100.sp, fontSize: 12.sp, onPressed: () {}, text: "Heart Attack"),
                ],
              ),
            ),
            15.verticalSpace,
            Container(
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(18.sp, 20.sp, 18.sp, 20.sp),
              decoration: BoxDecoration(
                color: AppColors.greyBg,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(color: Colors.grey.withValues(alpha: 0.1), spreadRadius: 2, blurRadius: 10, offset: const Offset(0, 5)),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "View Patient Past Records",
                    style: GoogleFonts.dmSans(fontSize: 16.sp, color: Colors.black, fontWeight: FontWeight.w600),
                  ),

                  Container(
                    decoration: BoxDecoration(color: AppColors.whiteColor, shape: BoxShape.circle),
                    padding: EdgeInsets.all(8.sp),
                    child: Icon(Icons.arrow_forward_ios_sharp, color: AppColors.redColor),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container _patientDetailTile(String title, String subtitle) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(18.sp, 10.sp, 18.sp, 10.sp),
      decoration: BoxDecoration(
        color: AppColors.greyBg,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [BoxShadow(color: Colors.grey.withValues(alpha: 0.1), spreadRadius: 2, blurRadius: 10, offset: const Offset(0, 5))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: GoogleFonts.dmSans(fontSize: 14.sp, color: Colors.black54)),
          5.verticalSpace,
          Text(subtitle, style: GoogleFonts.dmSans(fontSize: 16.sp, color: AppColors.blackColor)),
        ],
      ),
    );
  }
}
