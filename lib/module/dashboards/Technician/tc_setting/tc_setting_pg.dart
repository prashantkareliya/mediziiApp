import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medizii/components/context_extension.dart';
import 'package:medizii/components/custom_appbar.dart';
import 'package:medizii/components/custom_dialog.dart';
import 'package:medizii/components/sharedPreferences_service.dart';
import 'package:medizii/constants/app_colours/app_colors.dart';
import 'package:medizii/constants/helpers.dart';
import 'package:medizii/constants/strings.dart';
import 'package:medizii/gen/assets.gen.dart';
import 'package:medizii/main.dart';
import 'package:medizii/module/authentication/auth_screen.dart';
import 'package:medizii/module/dashboards/Technician/bloc/technician_bloc.dart';
import 'package:medizii/module/dashboards/Technician/data/technician_datasource.dart';
import 'package:medizii/module/dashboards/Technician/data/technician_repository.dart';
import 'package:medizii/module/dashboards/Technician/tc_setting/tc_profile_pg.dart';
import 'package:medizii/notification_pg.dart';

class TechnicianSettingPage extends StatelessWidget {
  TechnicianSettingPage({super.key});

  final prefs = PreferenceService().prefs;

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
            PlatformAwareDialog.show(
              context: context,
              title: 'Logout',
              content: 'Are you sure you want to log out?',
              confirmText: 'Yes',
              cancelText: 'No',
              onConfirm: () {
                prefs.clear();
                navigationService.pushAndRemoveUntil(AuthScreen(false));
              },
              onCancel: () {
                print('User cancelled');
              },
            );
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
                    return SettingTile(title: options[index],
                        onTap: () {
                          switch (options[index]) {
                            case 'Profile':
                              navigationService.push(TechnicianProfilePage());
                              break;
                            case 'Notification':
                              navigationService.push(NotificationPage());
                              break;
                            case 'About Us':
                              print('About Us');
                              break;
                            case 'Contact Us':
                              print('Contact Us');
                              break;
                            case 'Privacy Policy':
                              print('Privacy Policy');
                              break;
                            default:
                            // fallback
                              break;
                          }
                        });
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
  final VoidCallback onTap;

  const SettingTile({super.key, required this.title, required this.onTap});

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
          onTap: onTap
      ),
    );
  }
}

class DeleteAccountTile extends StatelessWidget {
  DeleteAccountTile({super.key});

  final prefs = PreferenceService().prefs;
  TechnicianBloc technicianBloc = TechnicianBloc(TechnicianRepository(technicianDatasource: TechnicianDatasource()));
  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TechnicianBloc, TechnicianState>(
      bloc: technicianBloc,
      listener: (context, state) {
        if (state is FailureState) {
          showSpinner = false;
          Helpers.showSnackBar(context, state.error);
        }
        if (state is LoadingState) {
          showSpinner = true;
        }
        if (state is LoadedState) {
          showSpinner = false;
          navigationService.pushAndRemoveUntil(AuthScreen(false));
        }
      },
      builder: (context, state) {
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
            onTap: () {
              PlatformAwareDialog.show(
                context: context,
                title: 'Delete',
                content: 'Are you sure you want to Delete Account?',
                confirmText: 'Yes',
                cancelText: 'No',
                onConfirm: () {
                  technicianBloc.add(DeleteTechnicianEvent(prefs.getString(PreferenceString.prefsUserId).toString()));
                },
                onCancel: () {

                },
              );
            },
          ),
        );
      },
    );
  }
}
