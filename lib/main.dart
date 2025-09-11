import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medizii/components/custom_loader.dart';
import 'package:medizii/components/navigation_service.dart';
import 'package:medizii/module/dashboards/doctor/dr_dashboard_setup.dart';
import 'package:provider/provider.dart';

import 'components/sharedPreferences_service.dart';
import 'constants/app_colours/app_colors.dart';
import 'module/authentication/auth_provider.dart';
import 'module/authentication/role_selection_screen.dart';
import 'module/dashboards/Technician/technician_dashboard_setup.dart';
import 'module/dashboards/bottom_bav_provider.dart';
import 'module/dashboards/patient/patient_dashboard_setup.dart';
import 'notification.dart';


final NavigationService navigationService = NavigationService();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isIOS) {
    await Firebase.initializeApp();
  } else {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
          apiKey: "AIzaSyBUtgtLLkjxiFLrK46OLJYNAQGViVL5zBY",
          appId: "1:936649424706:android:d8a0ee94e6d2e1381752db",
          messagingSenderId: "936649424706",
          projectId: "medizii-8997a",
        ));
  }
  await PreferenceService().init();
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => AuthProvider()), ChangeNotifierProvider(create: (_) => BottomNavProvider())],
      child: MyApp(),
    ),
  );

  initializeLocalNotifications();
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print("Received message in foreground: ${message.notification?.title}");
    if (message.notification != null) {
      showFlutterLocalNotification(message);
    }
  });
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling a background message: ${message.notification?.title}');
}

Future<void> requestNotificationPermission() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print("User granted permission");
  } else {
    print("User denied or not accepted permission");
  }
  if (Platform.isIOS) {
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      useInheritedMediaQuery: true,
      builder: (context, child) {
        return MaterialApp(
          navigatorKey: navigationService.navigatorKey,
          debugShowCheckedModeBanner: false,
          title: 'Ambulance booking App',
          theme: ThemeData(
            primarySwatch: Colors.orange,
            useMaterial3: true,
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            scaffoldBackgroundColor: AppColors.whiteColor,
            colorScheme: ColorScheme.fromSwatch().copyWith(primary: AppColors.primaryColor, secondary: AppColors.whiteColor),
          ),
          home: child,
        );
      },
        child: SplashScreen());
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final prefs = PreferenceService().prefs;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      _navigateBasedOnPrefs();
    });
  }

  void _navigateBasedOnPrefs() {
    final token = prefs.getString("token");
    final role = prefs.getString("role");

    if (token != null && role != null) {
      switch (role) {
        case 'doctor':
          navigationService.pushReplacement(DoctorDashboard());
          break;
        case 'patient':
          navigationService.pushReplacement(PatientDashboard());
          break;
        case 'technician':
          navigationService.pushReplacement(TechnicianDashboard());
          break;
        default:
          navigationService.pushReplacement(RoleSelectionScreen());
      }
    } else {
      navigationService.pushReplacement(RoleSelectionScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CustomLoader()));
  }
}
///Add this in pod file for permission handler
/*
post_install do |installer|
installer.pods_project.targets.each do |target|
target.build_configurations.each do |config|
config.build_settings['GCC_PREPROCESSOR_DEFINITIONS'] ||= ['$(inherited)', 'PERMISSION_CAMERA=1', 'PERMISSION_PHOTOS=1', 'PERMISSION_MEDIA_LIBRARY=1']
end
end
end*/
