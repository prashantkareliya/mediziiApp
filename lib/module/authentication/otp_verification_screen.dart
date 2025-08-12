import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medizii/components/context_extension.dart';
import 'package:medizii/components/custom_button.dart';
import 'package:medizii/constants/app_colours/app_colors.dart';
import 'package:medizii/constants/fonts/font_weight.dart';
import 'package:medizii/constants/strings.dart';
import 'package:medizii/gen/assets.gen.dart';
import 'package:medizii/main.dart';

import 'create_new_password_screen.dart';

class OtpVerification extends StatelessWidget {
  OtpVerification({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Assets.images.bg.image(fit: BoxFit.fill),
          Column(
            children: [
              30.verticalSpace,
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    navigationService.pop();
                  },
                ),
              ),
              50.verticalSpace,
              Text(
                LabelString.labelVerification,
                style: GoogleFonts.dmSans(color: AppColors.redColor, fontSize: 22.sp, fontWeight: GoogleFontWeight.semiBold),
              ),
              10.verticalSpace,
              Text(
                "We’ve sent OTP to your register email at *****abc@gmail.com. \nPlease enter 4 digit cod you receive.",
                textAlign: TextAlign.center,
                style: GoogleFonts.dmSans(color: AppColors.gray, fontSize: 14.sp, fontWeight: GoogleFontWeight.semiBold),
              ),
              20.verticalSpace,
              CustomButton(
                width: context.width() * 0.8,
                onPressed: () {
                  //if (_formKey.currentState!.validate()) {}
                  navigationService.push(CreateNewPassword());
                },
                text: "Enter password",
              ),
              15.verticalSpace,
              Text(
                LabelString.labelNotReceiveCode,
                textAlign: TextAlign.center,
                style: GoogleFonts.dmSans(color: AppColors.black, fontSize: 14.sp),
              ),
              8.verticalSpace,
              Text(
                LabelString.labelResendCode,
                textAlign: TextAlign.center,
                style: GoogleFonts.dmSans(
                  color: Color(0xFF0066E3),
                  fontSize: 14.sp,
                  decoration: TextDecoration.underline,
                  decorationColor: Color(0xFF0066E3),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
