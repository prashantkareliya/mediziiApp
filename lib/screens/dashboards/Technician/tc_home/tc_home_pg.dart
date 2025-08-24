import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medizii/constants/app_colours/app_colors.dart';
import 'package:medizii/constants/strings.dart';
import 'package:medizii/gen/assets.gen.dart';
import 'package:medizii/screens/dashboards/Technician/tc_home/tc_new_request_dialog.dart';

class TechnicianHomePage extends StatefulWidget {
  const TechnicianHomePage({super.key});

  @override
  State<TechnicianHomePage> createState() => _TechnicianHomePageState();
}

class _TechnicianHomePageState extends State<TechnicianHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/technician_bg.png"), fit: BoxFit.fill)),
            padding: EdgeInsets.symmetric(horizontal: 20.sp, vertical: 15.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                25.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 40.sp,
                      width: 40.sp,
                      decoration: BoxDecoration(
                        color: AppColors.whiteColor, // Border color
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.whiteColor, width: 2),
                        image: DecorationImage(
                          image: NetworkImage(
                            'https://www.careerstaff.com/wp-content/uploads/2024/04/how-to-improve-patient-experience-satisfaction-scores.jpg',
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(color: Colors.white12, borderRadius: BorderRadius.circular(25)),
                      child: Assets.icIcons.notification.svg(colorFilter: ColorFilter.mode(AppColors.whiteColor, BlendMode.srcIn)),
                    ),
                  ],
                ),
                20.verticalSpace,
                Text(
                  LabelString.labelGoodMorning,
                  style: GoogleFonts.dmSans(color: AppColors.whiteColor, fontSize: 14.sp, fontWeight: FontWeight.w400),
                ),
                3.verticalSpace,
                Text('Nina Decosta', style: GoogleFonts.dmSans(color: AppColors.whiteColor, fontSize: 24.sp, fontWeight: FontWeight.w600)),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.fromLTRB(18.sp, 10.sp, 18.sp, 5.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    LabelString.labelActiveRide,
                    style: GoogleFonts.dmSans(color: AppColors.blackColor, fontSize: 14.sp, fontWeight: FontWeight.w700),
                  ),
                  7.verticalSpace,
                  //Assets.images.noRide.image(),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.fromLTRB(18.sp, 10.sp, 18.sp, 10.sp),
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: const Color(0xFFFF6B6B), width: 2),
                      boxShadow: [
                        BoxShadow(color: Colors.grey.withValues(alpha: 0.1), spreadRadius: 2, blurRadius: 10, offset: const Offset(0, 5)),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Pickup Row
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Pickup icon & line
                            Column(
                              children: [
                                Assets.icIcons.location1.svg(colorFilter: ColorFilter.mode(AppColors.blueColor, BlendMode.srcIn)),
                                DottedLine(
                                  direction: Axis.vertical,
                                  lineLength: 0.035.sh,
                                  lineThickness: 1.5,
                                  dashLength: 6.0,
                                  dashColor: Colors.black,
                                  dashGapLength: 1.5,
                                ),
                                Assets.icIcons.location.svg(colorFilter: ColorFilter.mode(AppColors.redColor, BlendMode.srcIn)),
                              ],
                            ),
                            const SizedBox(width: 12),
                            // Location details
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Pickup
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        LabelString.labelPickupLocation,
                                        style: GoogleFonts.dmSans(fontSize: 12.sp, color: AppColors.gray),
                                      ),
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
                                        child: Assets.icIcons.location.svg(
                                          colorFilter: ColorFilter.mode(AppColors.redColor, BlendMode.srcIn),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        16.verticalSpace,
                        GestureDetector(
                          onTap: () {
                            showDialog(context: context, builder: (context) => TechnicianNewRequestDialog());
                          },
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(color: AppColors.grey, width: 1),
                            ),
                            child: Center(
                              child: Text(
                                LabelString.labelViewDetail,
                                style: GoogleFonts.dmSans(fontSize: 16.sp, fontWeight: FontWeight.w600, color: AppColors.redColor),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  20.verticalSpace,
                  Text(
                    LabelString.labelHistory,
                    style: GoogleFonts.dmSans(color: AppColors.blackColor, fontSize: 14.sp, fontWeight: FontWeight.w700),
                  ),
                  7.verticalSpace,
                  Expanded(
                    child: ListView.separated(
                      dragStartBehavior: DragStartBehavior.start,
                      physics: BouncingScrollPhysics(),
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount: 6,
                      itemBuilder: (context, index) {
                        return Container(
                          width: double.infinity,
                          padding: EdgeInsets.fromLTRB(18.sp, 10.sp, 18.sp, 10.sp),
                          decoration: BoxDecoration(
                            color: AppColors.greyBg,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withValues(alpha: 0.1),
                                spreadRadius: 2,
                                blurRadius: 10,
                                offset: const Offset(0, 5),
                              ),
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
                                  const SizedBox(width: 12),
                                  // Location details
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        // Pickup
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              LabelString.labelPickupLocation,
                                              style: GoogleFonts.dmSans(fontSize: 12.sp, color: AppColors.gray),
                                            ),
                                            Text(
                                              LabelString.labelDistance,
                                              style: GoogleFonts.dmSans(fontSize: 12.sp, color: AppColors.gray),
                                            ),
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
                                              style: GoogleFonts.dmSans(
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.redColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                        12.verticalSpace,
                                        Text(
                                          LabelString.labelDropLocation,
                                          style: GoogleFonts.dmSans(fontSize: 12.sp, color: AppColors.gray),
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "ABC Hospital",
                                              style: GoogleFonts.dmSans(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                                            ),
                                            Container(
                                              padding: EdgeInsets.all(8.sp),
                                              decoration: BoxDecoration(
                                                color: AppColors.iconBgColor,
                                                borderRadius: BorderRadius.circular(25),
                                              ),
                                              child: Assets.icIcons.location.svg(
                                                colorFilter: ColorFilter.mode(AppColors.redColor, BlendMode.srcIn),
                                              ),
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
                        );
                      },
                      separatorBuilder: (_, __) => 20.verticalSpace,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
