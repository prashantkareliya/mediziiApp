import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medizii/constants/app_colours/app_colors.dart';
import 'package:medizii/constants/strings.dart';
import 'package:medizii/gen/assets.gen.dart';
import 'package:medizii/main.dart';
import 'package:medizii/screens/dashboards/patient/patient_home/pt_reposts_upload_pg.dart';
import 'package:medizii/notification.dart';

class PatientHomePage extends StatelessWidget {
  const PatientHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/home_bg.png"), fit: BoxFit.fill)),
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
                    GestureDetector(
                      onTap: () {
                        navigationService.push(NotificationPage());
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.textSecondary.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Assets.icIcons.notification.svg(colorFilter: ColorFilter.mode(AppColors.whiteColor, BlendMode.srcIn)),
                      ),
                    ),
                  ],
                ),
                20.verticalSpace,
                Text(
                  LabelString.labelGoodMorning,
                  style: GoogleFonts.dmSans(color: AppColors.blackColor, fontSize: 14.sp, fontWeight: FontWeight.w400),
                ),
                3.verticalSpace,
                Text(
                  'Nina Decosta',
                  style: GoogleFonts.dmSans(color: AppColors.blackColor, fontSize: 24.sp, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),

          Expanded(
            child: Padding(
              padding: EdgeInsets.fromLTRB(18.sp, 20.sp, 18.sp, 5.sp),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(18.sp),
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: const Color(0xFFFF6B6B), width: 2),
                      boxShadow: [
                        BoxShadow(color: Colors.grey.withOpacity(0.1), spreadRadius: 2, blurRadius: 10, offset: const Offset(0, 5)),
                      ],
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Ambulance On \nThe Way',
                              style: GoogleFonts.dmSans(fontSize: 18.sp, fontWeight: FontWeight.w600, color: AppColors.blackColor),
                            ),
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(8.sp),
                                  decoration: BoxDecoration(color: AppColors.iconBgColor, borderRadius: BorderRadius.circular(25)),
                                  child: Assets.icIcons.call.svg(colorFilter: ColorFilter.mode(AppColors.redColor, BlendMode.srcIn)),
                                ),
                                10.horizontalSpace,
                                Container(
                                  padding: EdgeInsets.all(8.sp),
                                  decoration: BoxDecoration(color: AppColors.iconBgColor, borderRadius: BorderRadius.circular(25)),
                                  child: Assets.icIcons.location.svg(colorFilter: ColorFilter.mode(AppColors.redColor, BlendMode.srcIn)),
                                ),
                              ],
                            ),
                          ],
                        ),
                        8.verticalSpace,
                        Divider(color: AppColors.gray.withValues(alpha: 0.3)),
                        8.verticalSpace,

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(LabelString.labelArrivedAt, style: GoogleFonts.dmSans(fontSize: 14.sp, color: AppColors.gray)),
                                Text(
                                  '8:30 PM',
                                  style: GoogleFonts.dmSans(fontSize: 18.sp, fontWeight: FontWeight.bold, color: AppColors.blackColor),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(LabelString.labelVehicleNo, style: GoogleFonts.dmSans(fontSize: 14.sp, color: AppColors.gray)),
                                Text(
                                  'KA 05 f 4214',
                                  style: GoogleFonts.dmSans(fontSize: 18.sp, fontWeight: FontWeight.bold, color: AppColors.blackColor),
                                ),
                              ],
                            ),
                          ],
                        ),
                        15.verticalSpace,
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.whiteColor,
                              foregroundColor: AppColors.primaryColor,
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                                side: const BorderSide(color: AppColors.grey, width: 1.2),
                              ),
                              elevation: 0,
                            ),
                            child: Text(
                              LabelString.labelViewDetail,
                              style: GoogleFonts.dmSans(fontSize: 16.sp, fontWeight: FontWeight.w600, color: AppColors.redColor),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  20.verticalSpace,
                  Row(
                    children: [
                      Expanded(
                        child: _buildHealthCard(
                          LabelString.labelReports,
                          'https://www.shutterstock.com/image-photo/indian-senior-doctor-watching-medical-260nw-2274219827.jpg',
                          const Color(0xFFE8F4FD),
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: _buildHealthCard(
                          LabelString.labelBloodData,
                          'https://iprocess.net/wp-content/uploads/2022/08/testing-blood.jpg',
                          const Color(0xFFE1F5FE),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHealthCard(String title, String imageUrl, Color backgroundColor) {
    return GestureDetector(
      onTap: () {
        navigationService.push(PtReportsUploadPage());
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: AppColors.greyBg, borderRadius: BorderRadius.circular(20)),
        child: Column(
          children: [
            Container(
              width: 85.sp,
              height: 85.sp,
              decoration: BoxDecoration(color: backgroundColor, shape: BoxShape.circle),
              child: ClipOval(child: Image.network(imageUrl, fit: BoxFit.cover)),
            ),
            12.verticalSpace,
            Text(title, style: GoogleFonts.dmSans(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black87)),
            12.verticalSpace,
          ],
        ),
      ),
    );
  }
}
