import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class NoDataScreen extends StatelessWidget {
  String? data;

  NoDataScreen({this.data, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.15),
            Image.asset("assets/images/profile.png", height: 70.sp),
            SizedBox(height: 20.sp),
            Text(
              "No data \nPlease search",
              textAlign: TextAlign.center,
              maxLines: 2,
              style: GoogleFonts.dmSans(
                textStyle: TextStyle(height: 1.0, fontSize: 20.sp, color: const Color(0xFF000000), fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
