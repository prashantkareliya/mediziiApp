import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medizii/constants/app_colours/app_colors.dart';
import 'package:medizii/constants/strings.dart';
import 'package:medizii/main.dart';
import 'package:medizii/screens/authentication/auth_screen.dart';

class NoInternetScreen extends StatelessWidget {
  const NoInternetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.wifi_off, size: 100, color: Colors.red),
              SizedBox(height: 20),
              Text(
                ErrorString.internetErr,
                style: GoogleFonts.dmSans(
                  textStyle: TextStyle(fontWeight: FontWeight.w500, fontSize: 20.sp, color: AppColors.textSecondary),
                ),
              ),
              SizedBox(height: 10),
              Text(
                ErrorString.checkInternetErr,
                style: GoogleFonts.dmSans(
                  textStyle: TextStyle(fontWeight: FontWeight.w500, fontSize: 14.sp, color: AppColors.textSecondary),
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  navigationService.pushReplacement(AuthScreen(false));
                },
                child: Text(
                  LabelString.labelRetry,
                  style: GoogleFonts.dmSans(textStyle: TextStyle(fontSize: 14.sp, color: AppColors.redColor)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
