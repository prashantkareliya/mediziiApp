import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medizii/constants/app_colours/app_colors.dart';
import 'package:medizii/constants/strings.dart';
import 'package:medizii/gen/assets.gen.dart';

import '../../../../components/custom_appbar.dart';

class TechnicianSummeryDetailPg extends StatelessWidget {
  const TechnicianSummeryDetailPg({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CustomAppBar(
        title: LabelString.labelPatientsSummary,
        rightWidget: Row(
          children: [
            GestureDetector(
              onTap: () {},
              child: Container(
                decoration: BoxDecoration(color: AppColors.greyBg, shape: BoxShape.circle),
                padding: EdgeInsets.all(6.sp),
                child: Assets.icIcons.call.svg(colorFilter: ColorFilter.mode(AppColors.redColor, BlendMode.srcIn)),
              ),
            ),
            10.horizontalSpace,
            GestureDetector(
              onTap: () {},
              child: Container(
                decoration: BoxDecoration(color: AppColors.greyBg, shape: BoxShape.circle),
                padding: EdgeInsets.all(6.sp),
                child: Assets.icIcons.video.svg(colorFilter: ColorFilter.mode(AppColors.redColor, BlendMode.srcIn)),
              ),
            ),
          ],
        ),
        isBack: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(23.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(16.sp),
              decoration: BoxDecoration(color: AppColors.greyBg, borderRadius: BorderRadius.circular(16)),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.network(
                      "https://inboundhealth.com/wp-content/uploads/iStock-1473155464.jpg",
                      width: 80.sp,
                      height: 80.sp,
                      fit: BoxFit.cover,
                    ),
                  ),
                  16.horizontalSpace,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Vonni Kiehn",
                        style: GoogleFonts.dmSans(fontSize: 18.sp, fontWeight: FontWeight.w600, color: AppColors.blackColor),
                      ),
                      4.verticalSpace,
                      Row(
                        children: [
                          Text("ID: #212", style: GoogleFonts.dmSans(fontSize: 14.sp, color: AppColors.gray)),
                          8.horizontalSpace,
                          const Text("•", style: TextStyle(color: AppColors.red)),
                          8.horizontalSpace,
                          Text("25 Jan 2025", style: GoogleFonts.dmSans(fontSize: 14.sp, color: AppColors.gray)),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            16.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [_buildInfoCard("Sex", "Female"), _buildInfoCard("Age", "28"), _buildInfoCard("Blood", "A+")],
            ),
            16.verticalSpace,
            _buildExpandableCard(
              title: "About",
              content:
                  "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since. Lorem Ipsum is simply dummy text.",
            ),
            12.verticalSpace,
            _buildExpandableCard(title: "Reports", content: "Reports content goes here..."),
            12.verticalSpace,
            _buildExpandableCard(title: "Lorem Ipsum", content: "Lorem Ipsum content goes here..."),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(String label, String value) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 4.sp),
        padding: EdgeInsets.all(14.sp),
        decoration: BoxDecoration(color: AppColors.greyBg, borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: GoogleFonts.dmSans(fontSize: 14.sp, color: AppColors.gray)),
            4.verticalSpace,
            Text(value, style: GoogleFonts.dmSans(fontSize: 16.sp, fontWeight: FontWeight.bold, color: AppColors.black)),
          ],
        ),
      ),
    );
  }

  // Expandable Card Widget
  Widget _buildExpandableCard({required String title, required String content}) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(color: AppColors.greyBg, borderRadius: BorderRadius.circular(12)),
      child: ExpansionTile(
        tilePadding: EdgeInsets.symmetric(horizontal: 16.sp),
        childrenPadding: EdgeInsets.fromLTRB(16.sp, 0.sp, 16.sp, 10.sp),
        title: Text(title, style: GoogleFonts.dmSans(fontSize: 16.sp, fontWeight: FontWeight.bold, color: AppColors.blackColor)),
        iconColor: AppColors.red,
        collapsedIconColor: AppColors.red,
        children: [Text(content, style: GoogleFonts.dmSans(fontSize: 14.sp, color: AppColors.gray))],
      ),
    );
  }
}
