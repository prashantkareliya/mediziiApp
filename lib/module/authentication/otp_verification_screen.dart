import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medizii/components/context_extension.dart';
import 'package:medizii/components/custom_button.dart';
import 'package:medizii/components/custom_loader.dart';
import 'package:medizii/components/sharedPreferences_service.dart';
import 'package:medizii/constants/app_colours/app_colors.dart';
import 'package:medizii/constants/fonts/font_weight.dart';
import 'package:medizii/constants/helpers.dart';
import 'package:medizii/constants/strings.dart';
import 'package:medizii/gen/assets.gen.dart';
import 'package:medizii/main.dart';
import 'package:medizii/module/authentication/bloc/auth_event.dart';
import 'package:medizii/module/authentication/create_new_password_screen.dart';
import 'package:medizii/module/authentication/model/create_user_response.dart';
import 'package:medizii/module/authentication/model/forget_password_request.dart';
import 'package:medizii/module/authentication/model/forget_password_response.dart';
import 'package:medizii/module/dashboards/Technician/technician_dashboard_setup.dart';
import 'package:medizii/module/dashboards/doctor/dr_dashboard_setup.dart';
import 'package:medizii/module/dashboards/patient/patient_dashboard_setup.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../components/custom_loading_wrapper.dart';
import 'bloc/auth_bloc.dart';
import 'bloc/auth_state.dart';
import 'data/datasource.dart';
import 'data/repository.dart';
import 'model/create_user_request.dart';

class OtpVerification extends StatefulWidget {
  CreateUserRequest? createUserRequest;
  ForgetPasswordRequest? forgetPasswordRequest;
  String? from;
  String? role;

  OtpVerification(this.from, {super.key, this.createUserRequest, this.forgetPasswordRequest, this.role});

  @override
  State<OtpVerification> createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<OtpVerification> {

  final int _otpLength = 4;
  List<FocusNode> _focusNodes = [];
  List<TextEditingController> _controllers = [];
  AuthBloc authBloc = AuthBloc(AuthRepository(authDatasource: AuthDatasource()));
  bool showSpinner = false;
  final prefs = PreferenceService().prefs;
  CreateUserResponse? user;
  ForgetPasswordResponse? passwordResponse;
  CreateUserRequest createUserRequest = CreateUserRequest();
  ForgetPasswordRequest forgetPasswordRequest = ForgetPasswordRequest();

  @override
  void initState() {
    super.initState();
    print(widget.createUserRequest?.toJson());
    _focusNodes = List.generate(_otpLength, (_) => FocusNode());
    _controllers = List.generate(_otpLength, (_) => TextEditingController());
  }

  @override
  void dispose() {
    for (var node in _focusNodes) {
      node.dispose();
    }
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _onOtpChanged(String value, int index) {
    if (value.length == 1 && index < _otpLength - 1) {
      _focusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
  }


  String _getOtp() {
    return _controllers.map((c) => c.text).join();
  }

  void _submitOtp() {
    String otp = _getOtp();
    if (otp.length < 4) {
      Helpers.showSnackBar(context, ErrorString.otpErr, isError: true);
    } else {
      _callApi(otp);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: BlocConsumer<AuthBloc, AuthState>(
        bloc: authBloc,
        listener: (context, state) async {
          if (state is FailureState) {
            showSpinner = false;
            Helpers.showSnackBar(context, state.error);
          }
          if (state is LoadingState) {
            showSpinner = true;
          }
          if (state is LoadedState) {
            showSpinner = false;
            //For create user
            if (state.data is CreateUserResponse) {
              user = state.data;

              //Condition for resent otp api call
              if (user?.message == "OTP sent to phone") {
                Helpers.showSnackBar(context, user?.message ?? "");
              } else if (user != null) {
                prefs.setString("token", user!.token.toString());
                prefs.setString("role", user!.data!.role.toString());

                switch (user!.data!.role.toString()) {
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
            } else

            //For Forget Password
            if (state.data is ForgetPasswordResponse) {
              passwordResponse = state.data;
              if (passwordResponse?.message == "OTP sent to phone") {
                Helpers.showSnackBar(context, passwordResponse?.message ?? "");
              } else {
                Helpers.showSnackBar(context, passwordResponse?.message ?? "");
                navigationService.push(CreateNewPassword(widget.role, forgetPasswordRequest));
              }
            }
          }
        },
        builder: (context, state) {
          return Stack(
            fit: StackFit.expand,
            children: [
              Assets.images.bg.image(fit: BoxFit.fill),
              LoadingWrapper(
                showSpinner: showSpinner,
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
                      LabelString.labelVerification,
                      style: GoogleFonts.dmSans(color: AppColors.redColor, fontSize: 22.sp, fontWeight: GoogleFontWeight.semiBold),
                    ),
                    10.verticalSpace,
                    Text(
                      "We’ve sent OTP to your mobile number at ${widget.createUserRequest?.phone ??
                          widget.forgetPasswordRequest?.phone}. \nPlease enter 4 digit cod you receive.",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.dmSans(color: AppColors.gray, fontSize: 14.sp, fontWeight: GoogleFontWeight.semiBold),
                    ),
                    20.verticalSpace,
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 50.sp),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(_otpLength, (index) {
                          return SizedBox(
                            width: 45,
                            child: TextFormField(
                              controller: _controllers[index],
                              focusNode: _focusNodes[index],
                              keyboardType: TextInputType.number,
                              maxLength: 1,
                              textAlign: TextAlign.center,
                              onTapOutside: (d) {
                                FocusScope.of(context).requestFocus(FocusNode());
                              },
                              decoration: InputDecoration(
                                counter: SizedBox.shrink(),
                                hintStyle: GoogleFonts.dmSans(
                                  textStyle: TextStyle(
                                      fontWeight: FontWeight.w500, fontSize: 12.sp, color: AppColors.textSecondary.withValues(alpha: 0.2)),
                                ),
                                filled: true,
                                fillColor: const Color(0xFFFCFCFC),
                                contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(color: AppColors.primaryColor.withValues(alpha: 0.2), width: 1.5),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(color: AppColors.primaryColor, width: 1),
                                ),
                                errorStyle: GoogleFonts.dmSans(
                                  textStyle: TextStyle(fontSize: 12.sp, color: AppColors.errorRed),
                                ),

                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(color: AppColors.red, width: 1),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(color: AppColors.red, width: 1),
                                ),
                              ),
                              onChanged: (value) => _onOtpChanged(value, index),

                            ),
                          );
                        }),
                      ),
                    ),
                    20.verticalSpace,
                    CustomButton(
                      width: context.width() * 0.8,
                      onPressed: () {
                        _submitOtp();
                      },
                      text: widget.from != "forget_password" ? LabelString.labelRegister : LabelString.labelConfirmOtp,
                    ),
                    15.verticalSpace,
                    Text(
                      LabelString.labelNotReceiveCode,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.dmSans(color: AppColors.black, fontSize: 14.sp),
                    ),
                    IconButton(onPressed: () {
                      callResendOtpAPI();
                    }, icon: Text(
                      LabelString.labelResendCode,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.dmSans(
                        color: Color(0xFF0066E3),
                        fontSize: 14.sp,
                        decoration: TextDecoration.underline,
                        decorationColor: Color(0xFF0066E3),
                      ),
                    ),)
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  _callApi(String otp) {
    if (widget.from != "forget_password") {
      createUserRequest.name = widget.createUserRequest?.name;
      createUserRequest.email = widget.createUserRequest?.email;
      createUserRequest.phone = widget.createUserRequest?.phone;
      createUserRequest.password = widget.createUserRequest?.password;
      createUserRequest.role = widget.createUserRequest?.role;
      createUserRequest.sex = widget.createUserRequest?.sex;
      createUserRequest.age = widget.createUserRequest?.age;
      createUserRequest.otp = otp;

      // Role-specific fields
      switch (widget.createUserRequest?.role) {
        case 'Doctor':
          createUserRequest.hospital = widget.createUserRequest?.hospital;
          createUserRequest.occupation = widget.createUserRequest?.occupation;
          createUserRequest.experience = widget.createUserRequest?.experience;
          createUserRequest.type = widget.createUserRequest?.type;
          break;

        case 'Patient':
          createUserRequest.blood = widget.createUserRequest?.blood;
          break;

        case 'Technician':
          createUserRequest.experience = widget.createUserRequest?.experience;
          createUserRequest.blood = widget.createUserRequest?.blood;
          break;

        default:
          print('Unknown role: ${widget.createUserRequest?.role}');
          return;
      }
      // Single event for all user types
      authBloc.add(CreateUserEvent(createUserRequest));
      debugPrint(createUserRequest.toJson().toString());
    } else {
      forgetPasswordRequest.phone = widget.forgetPasswordRequest?.phone;
      forgetPasswordRequest.otp = otp;
      authBloc.add(SendOtpEvent(forgetPasswordRequest, widget.role.toString()));
    }
  }

  void callResendOtpAPI() {
    if (widget.from != "forget_password") {
      createUserRequest.name = widget.createUserRequest?.name;
      createUserRequest.email = widget.createUserRequest?.email;
      createUserRequest.phone = widget.createUserRequest?.phone;
      createUserRequest.password = widget.createUserRequest?.password;
      createUserRequest.role = widget.createUserRequest?.role;
      createUserRequest.sex = widget.createUserRequest?.sex;
      createUserRequest.age = widget.createUserRequest?.age;

      // Role-specific fields
      switch (widget.createUserRequest?.role) {
        case 'Doctor':
          createUserRequest.hospital = widget.createUserRequest?.hospital;
          createUserRequest.occupation = widget.createUserRequest?.occupation;
          createUserRequest.experience = widget.createUserRequest?.experience;
          createUserRequest.type = widget.createUserRequest?.type;
          break;

        case 'Patient':
          createUserRequest.blood = widget.createUserRequest?.blood;
          break;

        case 'Technician':
          createUserRequest.experience = widget.createUserRequest?.experience;
          ;
          createUserRequest.blood = widget.createUserRequest?.blood;
          break;

        default:
          print('Unknown role: ${widget.createUserRequest?.role}');
          return;
      }
    } else {
      forgetPasswordRequest.phone = widget.forgetPasswordRequest?.phone;
      authBloc.add(SendOtpEvent(forgetPasswordRequest, widget.role.toString()));
    }
  }
}
