import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medizii/components/custom_button.dart';
import 'package:medizii/components/cutom_textfield.dart';
import 'package:medizii/constants/app_colours/app_colors.dart';
import 'package:medizii/constants/fonts/font_weight.dart';
import 'package:medizii/constants/strings.dart';
import 'package:medizii/gen/assets.gen.dart';
import 'package:medizii/main.dart';
import 'package:medizii/module/authentication/auth_screen.dart';

class CreateNewPassword extends StatelessWidget {
   CreateNewPassword({super.key});

  final TextEditingController newPassword = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();
  final _formKey = GlobalKey<FormState>();

   final ValueNotifier<bool> _obscureTextNotifierNew = ValueNotifier<bool>(true);
   final ValueNotifier<bool> _obscureTextNotifierConfirm = ValueNotifier<bool>(true);

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
                  LabelString.labelCreateNewPassword,
                  style: GoogleFonts.dmSans(color: AppColors.redColor, fontSize: 22.sp, fontWeight: GoogleFontWeight.semiBold),
                ),
                10.verticalSpace,
                Text(
                  "Create new password for your account.",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.dmSans(color: Color(0xFF1F2125), fontSize: 14.sp),
                ),
                20.verticalSpace,
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 18.sp, vertical: 10.sp),
                  padding: EdgeInsets.symmetric(horizontal: 18.sp, vertical: 10.sp),
                  decoration: BoxDecoration(color: AppColors.grey.shade100, borderRadius: BorderRadius.circular(14.r)),
                  child: Column(
                    children: [
                      ValueListenableBuilder<bool>(
                          valueListenable: _obscureTextNotifierNew,
                          builder: (BuildContext context, bool isObscured, Widget? child) {
                            return CustomTextField(
                              label: LabelString.labelNewPassword,
                              controller: newPassword,
                              hintText: LabelString.labelEnterNewPassword,
                              textInputType: TextInputType.name,
                              obscureText: isObscured,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return ErrorString.passwordErr;
                                }
                                return null;
                              },
                              suffixIcon: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                                child: GestureDetector(
                                    onTap: () {
                                      _obscureTextNotifierNew.value = !isObscured;
                                    },
                                    child: Icon(Icons.remove_red_eye_rounded, color: isObscured ? Color(0xFFBABBBE) : AppColors.primaryColor)
                                ),
                              ),
                            );
                          }
                      ),

                      ValueListenableBuilder<bool>(
                          valueListenable: _obscureTextNotifierConfirm,
                          builder: (BuildContext context, bool isObscured, Widget? child) {
                            return CustomTextField(
                              label: LabelString.labelConfirmNewPassword,
                              controller: confirmPassword,
                              hintText: LabelString.labelEnterConfirmNewPassword,
                              textInputType: TextInputType.name,
                              obscureText: isObscured,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return ErrorString.passwordErr;
                                }
                                return null;
                              },
                              suffixIcon: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                                child: GestureDetector(
                                    onTap: () {
                                      _obscureTextNotifierConfirm.value = !isObscured;
                                    },
                                    child: Icon(Icons.remove_red_eye_rounded, color: isObscured ? Color(0xFFBABBBE) : AppColors.primaryColor)
                                ),
                              ),
                            );
                          }
                      ),
                      const SizedBox(height: 16),
                      CustomButton(
                        onPressed: () {
                          //if (_formKey.currentState!.validate()) {}
                          navigationService.pushAndRemoveUntil(AuthScreen(false));
                        },
                        text: LabelString.labelSavePassword,
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
