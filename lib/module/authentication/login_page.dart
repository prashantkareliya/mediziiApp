import 'dart:convert';

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
import 'package:medizii/constants/helpers.dart';
import 'package:medizii/constants/strings.dart';
import 'package:medizii/main.dart';
import 'package:medizii/module/authentication/bloc/auth_bloc.dart';
import 'package:medizii/module/authentication/bloc/auth_event.dart';
import 'package:medizii/module/authentication/data/datasource.dart';
import 'package:medizii/module/authentication/data/repository.dart';
import 'package:medizii/module/authentication/model/login_request.dart';
import 'package:medizii/module/authentication/model/login_response.dart';
import 'package:medizii/module/dashboards/Technician/technician_dashboard_setup.dart';
import 'package:medizii/module/dashboards/doctor/dr_dashboard_setup.dart';
import 'package:medizii/module/dashboards/patient/patient_dashboard_setup.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'bloc/auth_state.dart';
import 'forgot_password_screeen.dart';

class LoginTab extends StatefulWidget {
  String? selectedRole;

  LoginTab(this.selectedRole, {super.key});

  @override
  State<LoginTab> createState() => _LoginTabState();
}

class _LoginTabState extends State<LoginTab> {
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passCtrl = TextEditingController();
  final ValueNotifier<bool> _obscureTextNotifier = ValueNotifier<bool>(true);
  final _formKey = GlobalKey<FormState>();

  AuthBloc authBloc = AuthBloc(AuthRepository(authDatasource: AuthDatasource()));
  bool showSpinner = false;
  final prefs = PreferenceService().prefs;

  LoginRequest loginRequest = LoginRequest();
  LoginResponse? user;

  @override
  void dispose() {
    super.dispose();
    emailCtrl.dispose();
    passCtrl.dispose();
    _obscureTextNotifier.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: BlocConsumer<AuthBloc, AuthState>(
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
            showSpinner = false;
            user = state.data;
            if (user != null) {
              prefs.setString(PreferenceString.prefsToken, user!.token.toString());
              prefs.setString(PreferenceString.prefsRole, user!.data!.role.toString());
              prefs.setString(PreferenceString.prefsUserId, user!.data!.sId.toString());
              prefs.setString(PreferenceString.prefsName, user!.data!.name.toString());
              prefs.setString(PreferenceString.prefsPhone, user!.data!.phone.toString());
              switch (user?.data?.role) {
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
                  print('Unknown role:');
              }
            }
          }
        },
        builder: (context, state) {
          return LoadingWrapper(
            showSpinner: showSpinner,
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomTextField(
                      label: LabelString.labelEmailAddress,
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
                    ValueListenableBuilder<bool>(
                      valueListenable: _obscureTextNotifier,
                      builder: (BuildContext context, bool isObscured, Widget? child) {
                        return CustomTextField(
                          label: LabelString.labelPassword,
                          controller: passCtrl,
                          hintText: LabelString.labelEnterPassword,
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
                                _obscureTextNotifier.value = !isObscured;
                              },
                              child: Icon(Icons.remove_red_eye_rounded, color: isObscured ? Color(0xFFBABBBE) : AppColors.primaryColor),
                            ),
                          ),
                        );
                      },
                    ),

                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {
                          navigationService.push(ForgotPassword(widget.selectedRole));
                        },
                        child: Text(
                          LabelString.labelForgotPassword,
                          style: GoogleFonts.dmSans(
                            textStyle: TextStyle(fontWeight: FontWeight.w500, fontSize: 12.sp, color: AppColors.textSecondary),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    CustomButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          loginRequest.phone = emailCtrl.text.trim();
                          loginRequest.password = passCtrl.text;
                          authBloc.add(LoginUserEvent(loginRequest, widget.selectedRole.toString()));
                          debugPrint("Login request for ${widget.selectedRole}: ${loginRequest.toJson()}");
                        }
                      },
                      text: LabelString.labelLogin,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
