import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medizii/components/sharedPreferences_service.dart';
import 'package:medizii/constants/app_colours/app_colors.dart';
import 'package:medizii/constants/strings.dart';
import 'package:medizii/gen/assets.gen.dart';
import 'package:medizii/module/dashboards/patient/patient_book_ems/patient_book_ems_pg.dart';
import 'package:medizii/module/dashboards/patient/patient_call_dr/patient_call_dr_pg.dart';
import 'package:medizii/module/dashboards/patient/patient_home/patient_home_pg.dart';
import 'package:medizii/module/dashboards/patient/patient_setting/patient_setting_pg.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../bottom_bav_provider.dart';

class PatientDashboard extends StatefulWidget {
  PatientDashboard({super.key});

  @override
  State<PatientDashboard> createState() => _PatientDashboardState();
}

class _PatientDashboardState extends State<PatientDashboard> {
  final List<Widget> _screens = [PatientHomePage(), PatientCallDrPage(), PatientBookEmsPage(), PatientSettingPage()];

  final prefs = PreferenceService().prefs;
  late IO.Socket socket;
  String? fcmToken;

  @override
  void initState() {
    super.initState();
    initFcmAndSocket();
  }

  Future<void> initFcmAndSocket() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission();
    fcmToken = await messaging.getToken();
    print("FCM token: $fcmToken");
    // connect socket
    socket = IO.io("https://medizii.onrender.com", <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': true,
    });

    socket.onConnect((_) {
      print("Socket connected: ${socket.id}");
      socket.emit("patient_online", {"patientId": prefs.getString(PreferenceString.prefsUserId), "fcmToken": fcmToken});
    });

    // handle when the app is opened from FCM (background/terminated)
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Message clicked!: ${message.data}');
      // You can navigate to booking screen and then accept via socket
      final bookingId = message.data['patientId'];
      // show accept UI too
    });
  }

  @override
  void dispose() {
    socket.dispose();
    super.dispose();
  }

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
          type: BottomNavigationBarType.fixed,
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
              icon: _buildInActiveIcon(Assets.icIcons.callDoc.svg()),
              label: LabelString.labelCallDoctor,
              activeIcon: _buildActiveIcon(Assets.icIcons.callDoc.svg(colorFilter: ColorFilter.mode(AppColors.blueColor, BlendMode.srcIn))),
            ),
            BottomNavigationBarItem(
              icon: _buildInActiveIcon(Assets.icIcons.amulance.svg()),
              label: LabelString.labelBookEms,
              activeIcon: _buildActiveIcon(
                Assets.icIcons.amulance.svg(colorFilter: ColorFilter.mode(AppColors.blueColor, BlendMode.srcIn)),
              ),
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
