import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medizii/components/custom_dialog.dart';
import 'package:medizii/components/sharedPreferences_service.dart';
import 'package:medizii/constants/app_colours/app_colors.dart';
import 'package:medizii/constants/strings.dart';
import 'package:medizii/gen/assets.gen.dart';
import 'package:medizii/module/dashboards/Technician/bloc/technician_bloc.dart';
import 'package:medizii/module/dashboards/Technician/data/technician_datasource.dart';
import 'package:medizii/module/dashboards/Technician/data/technician_repository.dart';
import 'package:medizii/module/dashboards/Technician/model/tc_accept_reject_request.dart';
import 'package:medizii/module/dashboards/Technician/tc_home/tc_home_pg.dart';
import 'package:medizii/module/dashboards/Technician/tc_patient/tc_patient_pg.dart';
import 'package:medizii/module/dashboards/Technician/tc_setting/tc_setting_pg.dart';
import 'package:medizii/module/dashboards/Technician/tc_upload_reports/tc_search_patient_pg.dart';
import 'package:medizii/module/dashboards/bottom_bav_provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class TechnicianDashboard extends StatefulWidget {
  TechnicianDashboard({super.key});

  @override
  State<TechnicianDashboard> createState() => _TechnicianDashboardState();
}

class _TechnicianDashboardState extends State<TechnicianDashboard> {
  final List<Widget> _screens = [TechnicianHomePage(), TechnicianPatientPage(), TechnicianSearchPatientPage(), TechnicianSettingPage()];
  TechnicianBloc technicianBloc = TechnicianBloc(TechnicianRepository(technicianDatasource: TechnicianDatasource()));
  final prefs = PreferenceService().prefs;
  late IO.Socket socket;
  Timer? timer;
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
      socket.emit("technician_online", {"technicianId": prefs.getString(PreferenceString.prefsUserId), "fcmToken": fcmToken});
      startSendingLocation();
    });

    // listen for new booking (socket)
    socket.on("new_booking", (data) {
      print("New booking received (socket): $data");
      // show UI to accept or decline
      _showAcceptDialog(data);
    });

    socket.onDisconnect((_) {
      print("Socket disconnected");
      stopSendingLocation();
    });

    // handle when the app is opened from FCM (background/terminated)
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Message clicked!: ${message.data}');
      // You can navigate to booking screen and then accept via socket
      final bookingId = message.data['bookingId'];
      // show accept UI too
    });
  }

  void startSendingLocation() {
    timer = Timer.periodic(Duration(seconds: 10), (_) async {
      Position pos = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      socket.emit("technician_location_update", {
        "technicianId": prefs.getString(PreferenceString.prefsUserId),
        "lat": pos.longitude,
        "lng": pos.latitude
      });
      debugPrint("Sent location ${pos.longitude}, ${pos.latitude}");
    });
  }

  void stopSendingLocation() {
    timer?.cancel();
  }

  void _showAcceptDialog(dynamic data) {
    final bookingId = data['bookingId'];
    PlatformAwareDialog.show(
        context: context,
        title: "New Booking",
        content: "Patient nearby. Accept?",
        confirmText: "Accept",
        cancelText: "Decline",
        onCancel: () {
          TechnicianAcceptRejectRequest technicianAcceptRejectRequest =
              TechnicianAcceptRejectRequest(
                bookingId: bookingId,
                technicianId: prefs.getString(PreferenceString.prefsUserId)
              );
          technicianBloc.add(EmsBookingRejectEvent(technicianAcceptRejectRequest));
        },
        onConfirm: () {
          TechnicianAcceptRejectRequest technicianAcceptRejectRequest =
          TechnicianAcceptRejectRequest(
              bookingId: bookingId,
              technicianId: prefs.getString(PreferenceString.prefsUserId)
          );
          technicianBloc.add(EmsBookingRejectEvent(technicianAcceptRejectRequest));
          socket.emit("accept_booking", {"technicianId": prefs.getString(PreferenceString.prefsUserId), "bookingId": bookingId});
        }
    );
  }

  @override
  void dispose() {
    stopSendingLocation();
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
          currentIndex: currentIndex,
          type: BottomNavigationBarType.fixed,

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
