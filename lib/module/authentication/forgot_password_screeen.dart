import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medizii/components/custom_button.dart';
import 'package:medizii/components/custom_loader.dart';
import 'package:medizii/components/custom_loading_wrapper.dart';
import 'package:medizii/components/cutom_textfield.dart';
import 'package:medizii/components/sharedPreferences_service.dart';
import 'package:medizii/constants/app_colours/app_colors.dart';
import 'package:medizii/constants/fonts/font_weight.dart';
import 'package:medizii/constants/helpers.dart';
import 'package:medizii/constants/strings.dart';
import 'package:medizii/gen/assets.gen.dart';
import 'package:medizii/main.dart';
import 'package:medizii/module/authentication/model/forget_password_request.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'bloc/auth_bloc.dart';
import 'bloc/auth_event.dart';
import 'bloc/auth_state.dart';
import 'data/datasource.dart';
import 'data/repository.dart';
import 'model/forget_password_response.dart';
import 'otp_verification_screen.dart';

class ForgotPassword extends StatelessWidget {
  String? selectedRole;

  ForgotPassword(this.selectedRole, {super.key});

  final TextEditingController emailCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  AuthBloc authBloc = AuthBloc(AuthRepository(authDatasource: AuthDatasource()));
  bool showSpinner = false;
  final prefs = PreferenceService().prefs;
  ForgetPasswordResponse? passwordResponse;

  ForgetPasswordRequest forgetPasswordRequest = ForgetPasswordRequest();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Assets.images.bg.image(fit: BoxFit.fill),
          BlocConsumer<AuthBloc, AuthState>(
            bloc: authBloc,
            listener: (context, state) {
              if (state is FailureState) {
                showSpinner = false;
                Helpers.showSnackBar(context, state.error);
              }
              if (state is LoadingState) {
                showSpinner = true;
              }
              if (state is LoadedState) {
                passwordResponse = state.data;

                Helpers.showSnackBar(context, passwordResponse?.message ?? "");
                navigationService.push(
                    OtpVerification(forgetPasswordRequest: forgetPasswordRequest, "forget_password", role: selectedRole));
              }
            },
            builder: (context, state) {
              return LoadingWrapper(
                showSpinner: showSpinner,
                child: Form(
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
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),
                            CustomButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  forgetPasswordRequest.phone = emailCtrl.text.trim();
                                  authBloc.add(SendOtpEvent(forgetPasswordRequest, selectedRole.toString()));
                                }
                              },
                              text: LabelString.labelSendOTP,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
