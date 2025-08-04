import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medizii/components/navigation_service.dart';

import 'constants/app_colours/app_colors.dart';
import 'module/authentication/role_selection_screen.dart';

final NavigationService navigationService = NavigationService();

void main() {
  runApp(const MyApp());
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
            /*pageTransitionsTheme: const PageTransitionsTheme(builders: {
              TargetPlatform.android: ZoomPageTransitionsBuilder(),
              TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
            }),*/
            scaffoldBackgroundColor: AppColors.whiteColor,
            colorScheme: ColorScheme.fromSwatch()
                .copyWith(primary: AppColors.primaryColor, secondary: AppColors.whiteColor),
          ),
          home: child,
        );
      },
      child: const RoleSelectionScreen(),
    );
  }
}
