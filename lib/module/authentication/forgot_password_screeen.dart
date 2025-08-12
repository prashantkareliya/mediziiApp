import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medizii/components/context_extension.dart';
import 'package:medizii/components/custom_button.dart';
import 'package:medizii/components/cutom_textfield.dart';
import 'package:medizii/constants/app_colours/app_colors.dart';
import 'package:medizii/constants/fonts/font_weight.dart';
import 'package:medizii/constants/strings.dart';
import 'package:medizii/gen/assets.gen.dart';
import 'package:medizii/main.dart';

import 'otp_verification_screen.dart';

class ForgotPassword extends StatelessWidget {
  ForgotPassword({super.key});

  final TextEditingController emailCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Assets.images.bg.image(fit: BoxFit.fill),
          Form(
            key: _formKey,
            child: Column(
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
                  LabelString.labelForgotPassword,
                  style: GoogleFonts.dmSans(color: AppColors.redColor, fontSize: 22.sp, fontWeight: GoogleFontWeight.semiBold),
                ),
                20.verticalSpace,
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 18.sp, vertical: 10.sp),
                  padding: EdgeInsets.symmetric(horizontal: 18.sp, vertical: 10.sp),

                  decoration: BoxDecoration(color: AppColors.grey.shade100, borderRadius: BorderRadius.circular(14.r)),
                  child: Column(
                    children: [
                      CustomTextField(
                        label: LabelString.labelEnterEmailAddress,
                        hintText: LabelString.labelEnterEmailAddress,
                        controller: emailCtrl,
                        textInputType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return ErrorString.emailAddressErr;
                          } else if (!emailCtrl.text.isValidEmail) {
                            return ErrorString.emailAddressValidErr;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      CustomButton(
                        onPressed: () {
                          //if (_formKey.currentState!.validate()) {}
                          navigationService.push(OtpVerification());
                        },
                        text: LabelString.labelSendOTP,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
