import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medizii/constants/app_colours/app_colors.dart';
import 'package:medizii/constants/strings.dart';
import 'package:medizii/gen/assets.gen.dart';
import 'package:medizii/module/dashboards/Technician/tc_home/tc_home_pg.dart';
import 'package:medizii/module/dashboards/Technician/tc_patient/tc_patient_pg.dart';
import 'package:medizii/module/dashboards/Technician/tc_setting/tc_setting_pg.dart';
import 'package:medizii/module/dashboards/Technician/tc_upload_reports/tc_search_patient_pg.dart';
import 'package:medizii/module/dashboards/bottom_bav_provider.dart';

class TechnicianDashboard extends StatelessWidget {
  TechnicianDashboard({super.key});

  final List<Widget> _screens = [TechnicianHomePage(), TechnicianPatientPage(), TechnicianSearchPatientPage(), TechnicianSettingPage()];

  @override
  Widget build(BuildContext context) {
    final int currentIndex = context.watch<BottomNavProvider>().currentIndex;

    return Scaffold(
      body: _screens[currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 10, offset: const Offset(0, -2))],
        ),
        child: BottomNavigationBar(
          iconSize: 25.r,
          currentIndex: currentIndex,
          onTap: (index) {
            // Refresh logic: Even if the same index is tapped, force refresh
            final provider = context.read<BottomNavProvider>();
            if (provider.currentIndex != index) {
              provider.setIndex(index);
            } else {
              provider.setIndex(index); // trigger rebuild intentionally
            }
          },
          selectedItemColor: AppColors.blueColor,
          unselectedItemColor: AppColors.gray,
          selectedLabelStyle: GoogleFonts.dmSans(
            textStyle: TextStyle(fontWeight: FontWeight.w500, fontSize: 12.sp, color: AppColors.textSecondary),
          ),
          unselectedLabelStyle: GoogleFonts.dmSans(
            textStyle: TextStyle(fontWeight: FontWeight.w500, fontSize: 12.sp, color: AppColors.textSecondary),
          ),

          items: [
            BottomNavigationBarItem(
              icon: _buildInActiveIcon(Assets.icIcons.home.svg()),
              label: LabelString.labelHome,
              activeIcon: _buildActiveIcon(Assets.icIcons.home.svg(colorFilter: ColorFilter.mode(AppColors.blueColor, BlendMode.srcIn))),
            ),
            BottomNavigationBarItem(
              icon: _buildInActiveIcon(Assets.icIcons.call.svg()),
              label: LabelString.labelPatients,
              activeIcon: _buildActiveIcon(Assets.icIcons.call.svg(colorFilter: ColorFilter.mode(AppColors.blueColor, BlendMode.srcIn))),
            ),
            BottomNavigationBarItem(
              icon: _buildInActiveIcon(Assets.icIcons.upload.svg()),
              label: LabelString.labelUploadReport,
              activeIcon: _buildActiveIcon(Assets.icIcons.upload.svg(colorFilter: ColorFilter.mode(AppColors.blueColor, BlendMode.srcIn))),
            ),
            BottomNavigationBarItem(
              icon: _buildInActiveIcon(Assets.icIcons.setting.svg()),
              label: LabelString.labelSetting,
              activeIcon: _buildActiveIcon(Assets.icIcons.setting.svg(colorFilter: ColorFilter.mode(AppColors.blueColor, BlendMode.srcIn))),
            ),
          ],
        ),
      ),
    );
  }

  _buildActiveIcon(SvgPicture icon) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.sp, vertical: 6.sp),
      decoration: BoxDecoration(
        color: Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: AppColors.transparent),
      ),
      child: icon,
    );
  }

  _buildInActiveIcon(SvgPicture icon) {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: AppColors.transparent)),
      padding: EdgeInsets.symmetric(horizontal: 8.sp, vertical: 6.sp),
      child: icon,
    );
  }
}
