import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medizii/components/custom_appbar.dart';
import 'package:medizii/constants/app_colours/app_colors.dart';
import 'package:medizii/constants/strings.dart';
import 'package:medizii/gen/assets.gen.dart';
import 'package:medizii/screens/dashboards/doctor/dr_upload_reports/dr_reports_upload_dialog.dart';

class DoctorReportsUploadPage extends StatelessWidget {
  const DoctorReportsUploadPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CustomAppBar(title: "Patient Name", isBack: true),
      body: Padding(
        padding: EdgeInsets.all(16.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DottedBorder(
              options: RoundedRectDottedBorderOptions(
                radius: Radius.circular(18.0),
                dashPattern: [7, 4],
                strokeWidth: 1.5,
                color: AppColors.blueColor,
              ),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 30.sp, vertical: 20.sp),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  //border: Border.all(color: AppColors.blueColor, width: 1),
                ),
                child: Column(
                  children: [
                    Container(
                      width: 60.sp,
                      height: 60.sp,
                      decoration: BoxDecoration(color: Colors.blue.withValues(alpha: 0.1), shape: BoxShape.circle),
                      child: Padding(
                        padding: EdgeInsets.all(15.sp),
                        child: Assets.icIcons.upload.svg(colorFilter: ColorFilter.mode(AppColors.blueColor, BlendMode.srcIn)),
                      ),
                    ),
                    15.verticalSpace,
                    RichText(
                      text: TextSpan(
                        text: "Click here ",
                        style: GoogleFonts.dmSans(fontSize: 16.sp, fontWeight: FontWeight.w700, color: AppColors.blackColor),
                        children: [
                          TextSpan(
                            text: 'to upload your file',
                            style: GoogleFonts.dmSans(fontSize: 16.sp, fontWeight: FontWeight.w500, color: Colors.black87),
                          ),
                        ],
                      ),
                    ),
                    6.verticalSpace,
                    Text(
                      'Supported Format: JPG, PNG, PDF\n(Max 10mb)',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.dmSans(fontSize: 14.sp, color: AppColors.gray),
                    ),
                  ],
                ),
              ),
            ),
            28.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  LabelString.labelUploadedFiles,
                  style: GoogleFonts.dmSans(fontSize: 18.sp, fontWeight: FontWeight.w600, color: AppColors.blackColor),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(color: AppColors.gray.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(25)),
                  child: Icon(Icons.swap_vert, color: AppColors.blackColor, size: 24),
                ),
              ],
            ),

            18.verticalSpace,

            // File List
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return DoctorMedicalReportDialog();
                        },
                      );
                    },
                    child: FileItem(
                      fileName: 'X-Ray Report.pdf',
                      fileSize: '3 MB',
                      uploadDate: '25 Jan 2025',
                      iconColor: Colors.red,
                      icon: Icons.picture_as_pdf,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FileItem extends StatelessWidget {
  final String fileName;
  final String fileSize;
  final String uploadDate;
  final Color iconColor;
  final IconData icon;

  const FileItem({
    Key? key,
    required this.fileName,
    required this.fileSize,
    required this.uploadDate,
    required this.iconColor,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18.sp, vertical: 14.sp),
      margin: EdgeInsets.symmetric(vertical: 5.sp),
      decoration: BoxDecoration(
        color: AppColors.greyBg,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 8, offset: const Offset(0, 2))],
      ),
      child: Row(
        children: [
          Container(
            width: 50.sp,
            height: 50.sp,
            padding: EdgeInsets.all(8.sp),
            decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.whiteColor),
            child: Assets.icIcons.pdf.svg(colorFilter: ColorFilter.mode(AppColors.redColor, BlendMode.srcIn)),
          ),
          14.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(fileName, style: GoogleFonts.dmSans(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black87)),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(fileSize, style: GoogleFonts.dmSans(fontSize: 14, color: Colors.grey[600])),
                    Text(' • ', style: GoogleFonts.dmSans(fontSize: 14, color: Colors.grey[600])),
                    Text(uploadDate, style: GoogleFonts.dmSans(fontSize: 14, color: Colors.grey[600])),
                  ],
                ),
              ],
            ),
          ),
          Container(
            width: 40.sp,
            height: 40.sp,
            padding: EdgeInsets.all(8.sp),
            decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(8)),
            child: Assets.icIcons.delete.svg(colorFilter: ColorFilter.mode(AppColors.gray, BlendMode.srcIn)),
          ),
        ],
      ),
    );
  }
}
