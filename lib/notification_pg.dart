import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medizii/components/custom_appbar.dart';
import 'package:medizii/constants/app_colours/app_colors.dart';
import 'package:medizii/constants/strings.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CustomAppBar(title: LabelString.labelNotification, isBack: true, isNotification: false),

      body: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 18.sp, vertical: 8.sp),
        itemCount: 10,
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.all(14.sp),
            decoration: BoxDecoration(color: AppColors.greyBg, borderRadius: BorderRadius.circular(15.0)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                  style: GoogleFonts.dmSans(fontSize: 14.sp, fontWeight: FontWeight.w500, color: AppColors.black),
                ),
                5.verticalSpace,
                Text("25 Jan 2025", style: GoogleFonts.dmSans(fontSize: 12.sp, fontWeight: FontWeight.w500, color: AppColors.gray)),
              ],
            ),
          );
        },
        separatorBuilder: (_, __) => SizedBox(height: 12.sp),
      ),
    );
  }
}
