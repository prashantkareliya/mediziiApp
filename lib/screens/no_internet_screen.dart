import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medizii/constants/app_colours/app_colors.dart';
import 'package:medizii/constants/strings.dart';
import 'package:medizii/main.dart';
import 'package:medizii/screens/authentication/auth_screen.dart';
import 'package:medizii/services/connectivity_service.dart';

class NoInternetScreen extends StatefulWidget {
  const NoInternetScreen({super.key});

  @override
  State<NoInternetScreen> createState() => _NoInternetScreenState();
}

class _NoInternetScreenState extends State<NoInternetScreen> {
  bool _isChecking = false;

  Future<void> _checkInternetAndRetry() async {
    setState(() {
      _isChecking = true;
    });

    try {
      final connectivityService = ConnectivityService();
      final isConnected = await connectivityService.checkConnectivity();

      if (isConnected) {
        // Internet is back, navigate to auth screen
        if (mounted) {
          navigationService.pushReplacement(AuthScreen(false));
        }
      } else {
        // Still no internet, show snackbar
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('No internet connection available'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error checking internet connection'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isChecking = false;
        });
      }
    }
  }

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
                  textStyle: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20.sp,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Text(
                ErrorString.checkInternetErr,
                style: GoogleFonts.dmSans(
                  textStyle: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14.sp,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: _isChecking ? null : _checkInternetAndRetry,
                child:
                    _isChecking
                        ? SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              AppColors.redColor,
                            ),
                          ),
                        )
                        : Text(
                          LabelString.labelRetry,
                          style: GoogleFonts.dmSans(
                            textStyle: TextStyle(
                              fontSize: 14.sp,
                              color: AppColors.redColor,
                            ),
                          ),
                        ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
