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

final NavigationService navigationService = NavigationService();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PreferenceService().init();
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => AuthProvider()), ChangeNotifierProvider(create: (_) => BottomNavProvider())],
      child: MyApp(),
    ),
  );
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
