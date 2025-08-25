import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:medizii/components/navigation_service.dart';
import 'package:medizii/components/connectivity_wrapper.dart';
import 'package:medizii/screens/dashboards/doctor/dr_dashboard_setup.dart';
import 'package:medizii/services/connectivity_service.dart';
import 'package:provider/provider.dart';

import 'constants/app_colours/app_colors.dart';
import 'providers/auth_provider.dart';
import 'screens/authentication/role_selection_screen.dart';
import 'screens/dashboards/provider/bottom_bav_provider.dart';

final NavigationService navigationService = NavigationService();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('authBox');

  // Initialize connectivity service
  await ConnectivityService().initialize();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()..loadToken()),
        ChangeNotifierProvider(create: (_) => BottomNavProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
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
            colorScheme: ColorScheme.fromSwatch().copyWith(
              primary: AppColors.primaryColor,
              secondary: AppColors.whiteColor,
            ),
          ),
          home: child,
        );
      },
      child: ConnectivityWrapper(
        child: Consumer<AuthProvider>(
          builder: (context, auth, _) {
            return auth.token != null
                ? DoctorDashboard()
                : RoleSelectionScreen();
          },
        ),
      ),
    );
  }
}
