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
import 'package:medizii/module/authentication/otp_verification_screen.dart';
import 'package:medizii/module/dashboards/Technician/technician_dashboard_setup.dart';
import 'package:medizii/module/dashboards/doctor/dr_dashboard_setup.dart';
import 'package:medizii/module/dashboards/patient/patient_dashboard_setup.dart';

import 'forgot_password_screeen.dart';


class AuthScreen extends StatefulWidget {
  bool check = true;

  String? selectedRole;

  AuthScreen(this.check, {super.key, this.selectedRole});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> with SingleTickerProviderStateMixin{
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) setState(() {});
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  double getContainerHeight(BuildContext context) {
    if (_tabController.index == 0) {
      return MediaQuery
          .of(context)
          .size
          .height * 0.32;
    } else {
      return MediaQuery
          .of(context)
          .size
          .height * 0.58;
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        body: Stack(
          fit: StackFit.expand,
          children: [
            Assets.images.bg.image(fit: BoxFit.fill),
            Column(
              children: [
                30.verticalSpace,
                if(widget.check)
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
                  LabelString.labelWelcomeTo,
                  style: GoogleFonts.dmSans(color: AppColors.redColor, fontSize: 22.sp, fontWeight: GoogleFontWeight.semiBold),
                ),
                20.verticalSpace,
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 18.sp),
                  padding: EdgeInsets.zero,
                  decoration: BoxDecoration(
                    color: AppColors.grey.shade100,
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                  child: Column(
                    children: [
                      Container(
                        height: 65.sp,
                        margin: EdgeInsets.symmetric(horizontal: 18.sp, vertical: 10.sp),
                        padding: EdgeInsets.zero,
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(30.r),
                        ),
                        child: TabBar(
                          controller: _tabController,
                          dividerColor: AppColors.transparent,
                          labelStyle: GoogleFonts.dmSans(fontSize: 14.sp, fontWeight: GoogleFontWeight.semiBold),
                          labelColor: AppColors.redColor,
                          unselectedLabelColor: Colors.black,
                          indicator: BoxDecoration(
                            color: AppColors.redColor.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(30.r),
                          ),
                          indicatorSize: TabBarIndicatorSize.tab,
                          indicatorPadding: EdgeInsets.all(6.sp),
                          tabs: [
                            Tab(text: LabelString.labelLogin),
                            Tab(text: LabelString.labelRegister),
                          ],
                        ),
                      ),
                      AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        height: getContainerHeight(context),
                        margin: EdgeInsets.symmetric(horizontal: 0.sp, vertical: 10),

                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            LoginTab(widget.selectedRole),
                            RegisterTab(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),


              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ----------------- Login Tab ----------------- //

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
      padding: const EdgeInsets.symmetric(horizontal: 32),
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
                  } else if (!emailCtrl.text.isValidEmail) {
                    return ErrorString.emailAddressValidErr;
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
                            child: Icon(Icons.remove_red_eye_rounded, color: isObscured ? Color(0xFFBABBBE) : AppColors.primaryColor)
                        ),
                      ),
                    );
                  }
              ),

              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    navigationService.push(ForgotPassword());
                  },
                  child: Text(LabelString.labelForgotPassword,
                      style: GoogleFonts.dmSans(
                          textStyle: TextStyle(fontWeight: FontWeight.w500, fontSize: 12.sp, color: AppColors.textSecondary))
                  ),
                ),
              ),
              const SizedBox(height: 16),
              CustomButton(
                onPressed: () {
                 /* if (_formKey.currentState!.validate()) {

                  }*/
                  switch (widget.selectedRole) {
                    case 'Doctor':
                      navigationService.push(DoctorDashboard());
                      break;
                    case 'Patient':
                      navigationService.push(PatientDashboard());
                      break;
                    case 'Technician':
                      navigationService.push(TechnicianDashboard());
                      break;
                    default:
                      print('Unknown role: ${widget.selectedRole}');
                  }

                }, text: LabelString.labelLogin,
              )
            ],
          ),
        ),
      ),
    );
  }
}

// ----------------- Register Tab ----------------- //

class RegisterTab extends StatefulWidget {

  RegisterTab({super.key});

  @override
  State<RegisterTab> createState() => _RegisterTabState();
}

class _RegisterTabState extends State<RegisterTab> {
  final List<String> roles = ['Doctor', 'Patient', 'Technician'];

  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController phoneCtrl = TextEditingController();
  final TextEditingController passCtrl = TextEditingController();
  final ValueNotifier<bool> _obscureTextNotifier = ValueNotifier<bool>(true);

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    nameCtrl.dispose();
    emailCtrl.dispose();
    phoneCtrl.dispose();
    passCtrl.dispose();
    _obscureTextNotifier.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String selectedRole = 'Select';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: StatefulBuilder(builder: (context, setState) {
        return SingleChildScrollView(
          child: Column(
            children: [
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Choose Role',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
                value: selectedRole == 'Select' ? null : selectedRole,
                hint: Text('Select'),
                items: roles.map((role) {
                  return DropdownMenuItem(
                    value: role,
                    child: Text(role),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() => selectedRole = value ?? 'Select');
                },
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: LabelString.labelFullName,
                hintText: LabelString.labelEnterName,
                controller: nameCtrl,
                textInputType: TextInputType.name,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return ErrorString.emailAddressErr;
                  }
                  return null;
                },
              ),
              CustomTextField(
                label: LabelString.labelEmailAddress,
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
              CustomTextField(
                label: LabelString.labelPhoneNumber,
                hintText: LabelString.labelEnterPhoneNumber,
                controller: phoneCtrl,
                textInputType: TextInputType.number,
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
                            child: Icon(Icons.remove_red_eye_rounded, color: isObscured ? Color(0xFFBABBBE) : AppColors.primaryColor)
                        ),
                      ),
                    );
                  }
              ),
              CustomButton(
                onPressed: () {
                  navigationService.push(OtpVerification());
                }, text: "${LabelString.labelRegister} Now",
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      }),
    );
  }
}
