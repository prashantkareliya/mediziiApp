import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medizii/components/context_extension.dart';
import 'package:medizii/components/custom_appbar.dart';
import 'package:medizii/constants/app_colours/app_colors.dart';
import 'package:medizii/constants/strings.dart';
import 'package:medizii/gen/assets.gen.dart';
import 'package:medizii/providers/auth_provider.dart';

class DoctorSettingPage extends StatelessWidget {
  DoctorSettingPage({super.key});

  final List<String> options = [
    'Profile',
    'Notification',
    'About Us',
    'Contact Us',
    'Privacy Policy',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CustomAppBar(
        title: LabelString.labelSetting,
        rightWidget: GestureDetector(
          onTap: () {
            AuthProvider().logout();
          },
          child: Container(
            padding: EdgeInsets.all(8.sp),
            decoration: BoxDecoration(color: AppColors.greyBg, shape: BoxShape.circle),
            child: Assets.icIcons.exit.svg(),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                itemCount: options.length + 1,
                separatorBuilder: (_, __) => SizedBox(height: 14.sp),
                itemBuilder: (context, index) {
                  if (index < options.length) {
                    return SettingTile(title: options[index]);
                  } else {
                    return DeleteAccountTile();
                  }
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 25.sp),
              child: Text('Version 2.1', style: GoogleFonts.dmSans(color: AppColors.blackColor, fontSize: 14.sp)),
            ),
          ],
        ),
      ),
    );
  }
}

class SettingTile extends StatelessWidget {
  final String title;

  const SettingTile({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: AppColors.greyBg, borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        title: Padding(
          padding: EdgeInsets.symmetric(vertical: 14.sp),
          child: Text(title, style: GoogleFonts.dmSans(color: AppColors.blackColor, fontSize: 15.sp, fontWeight: FontWeight.w500)),
        ),
        trailing: Icon(Icons.arrow_forward_ios, color: AppColors.redColor, size: 16.sp),
        onTap: () {
          // Handle tap
        },
      ),
    );
  }
}

class DeleteAccountTile extends StatelessWidget {
  const DeleteAccountTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width(),
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage("assets/images/home_bg.png"), fit: BoxFit.fill),
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        title: Text(
          LabelString.labelDeleteAccount,
          style: GoogleFonts.dmSans(color: AppColors.blackColor, fontSize: 15.sp, fontWeight: FontWeight.w500),
        ),
        onTap: () {},
      ),
    );
  }
}
