import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medizii/components/context_extension.dart';
import 'package:medizii/components/custom_button.dart';
import 'package:medizii/components/custom_dropdown_field.dart';
import 'package:medizii/components/custom_loader.dart';
import 'package:medizii/components/cutom_textfield.dart';
import 'package:medizii/constants/app_colours/app_colors.dart';
import 'package:medizii/constants/helpers.dart';
import 'package:medizii/constants/strings.dart';
import 'package:medizii/main.dart';
import 'package:medizii/module/authentication/bloc/auth_bloc.dart';
import 'package:medizii/module/authentication/bloc/auth_event.dart';
import 'package:medizii/module/authentication/data/datasource.dart';
import 'package:medizii/module/authentication/data/repository.dart';
import 'package:medizii/module/authentication/model/create_user_request.dart';
import 'package:medizii/module/authentication/model/hospitals_response.dart';
import 'package:medizii/module/authentication/otp_verification_screen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'bloc/auth_state.dart';
import 'model/create_user_response.dart';

class RegisterTab extends StatefulWidget {
  String? selectedRole;

  RegisterTab(this.selectedRole, {super.key});

  @override
  State<RegisterTab> createState() => _RegisterTabState();
}

class _RegisterTabState extends State<RegisterTab> {
  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController phoneCtrl = TextEditingController();
  final TextEditingController experienceCtrl = TextEditingController();
  final TextEditingController ageCtrl = TextEditingController();
  final TextEditingController passCtrl = TextEditingController();

  final ValueNotifier<bool> _obscureTextNotifier = ValueNotifier<bool>(true);
  late final ValueNotifier<String?> _selectOccupations = ValueNotifier<String?>(null);
  late final ValueNotifier<String?> _selectType = ValueNotifier<String?>(null);
  late final ValueNotifier<String?> _selectSex = ValueNotifier<String?>(null);
  late final ValueNotifier<HospitalData?> _selectHospital = ValueNotifier<HospitalData?>(null);
  late final ValueNotifier<String?> _selectBlood = ValueNotifier<String?>(null);

  final _formKey = GlobalKey<FormState>();
  AuthBloc authBloc = AuthBloc(AuthRepository(authDatasource: AuthDatasource()));
  bool showSpinner = false;
  CreateUserResponse? user;
  CreateUserRequest createUserRequest = CreateUserRequest();
  HospitalResponse? hospitalResponse;
  List<HospitalData>? hospitalList;

  @override
  void dispose() {
    super.dispose();
    nameCtrl.dispose();
    emailCtrl.dispose();
    phoneCtrl.dispose();
    passCtrl.dispose();
    experienceCtrl.dispose();
    ageCtrl.dispose();
    _obscureTextNotifier.dispose();
    _selectOccupations.dispose();
    _selectType.dispose();
    _selectSex.dispose();
    _selectHospital.dispose();
  }

  @override
  void initState() {
    super.initState();
    if (widget.selectedRole == "Doctor") {
      authBloc.add(FetchHospitalsEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
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

          if (hospitalList == null && widget.selectedRole == "Doctor") {
            hospitalResponse = state.data;
            hospitalList = hospitalResponse?.data;
          } else {
            user = state.data;
            Helpers.showSnackBar(context, user?.message ?? "");
            navigationService.push(OtpVerification(createUserRequest: createUserRequest, "registration"));
          }

        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          blur: 2.0,
          inAsyncCall: showSpinner,
          progressIndicator: CustomLoader(),
          child: Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                //Name
                CustomTextField(
                  label: LabelString.labelFullName,
                  hintText: LabelString.labelEnterName,
                  controller: nameCtrl,
                  textInputType: TextInputType.name,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return ErrorString.fullNameErr;
                    }
                    return null;
                  },
                ),

                //Email Address
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

                //Phone number
                CustomTextField(
                  label: LabelString.labelPhoneNumber,
                  hintText: LabelString.labelEnterPhoneNumber,
                  controller: phoneCtrl,
                  textInputType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return ErrorString.phoneErr;
                    }
                    return null;
                  },
                ),

                //Hospitals
                if (widget.selectedRole == "Doctor")
                  Padding(
                    padding: EdgeInsets.only(bottom: 7.sp),
                    child: ValueListenableBuilder<HospitalData?>(
                      valueListenable: _selectHospital,
                      builder: (BuildContext context, HospitalData? hospitalSelect, Widget? child) {
                        return DropdownButtonFormField<HospitalData>(
                          value: hospitalSelect,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: AppColors.primaryColor.withValues(alpha: 0.3)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: AppColors.primaryColor.withValues(alpha: 0.3)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: AppColors.primaryColor.withValues(alpha: 0.3)),
                            ),
                            errorStyle: GoogleFonts.dmSans(textStyle: TextStyle(fontSize: 12.sp, color: AppColors.errorRed)),
                            contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                          ),
                          style: GoogleFonts.dmSans(
                            textStyle: TextStyle(fontWeight: FontWeight.w500, fontSize: 12.sp, color: AppColors.textSecondary),
                          ),
                          hint: Text(
                            'Hospital',
                            style: GoogleFonts.dmSans(
                              textStyle: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 12.sp,
                                color: AppColors.textSecondary.withValues(alpha: 0.2),
                              ),
                            ),
                          ),
                          items:
                              hospitalList?.map((hospital) {
                                return DropdownMenuItem<HospitalData>(
                                  value: hospital,
                                  child: Text(hospital.name ?? ""), // Make sure HospitalData has a `name` property
                                );
                              }).toList(),
                          onChanged: (HospitalData? value) {
                            if (value != null) {
                              _selectHospital.value = value;
                            }
                          },
                          validator: (value) {
                            if (value == null) {
                              return ErrorString.hospitalErr;
                            }
                            return null;
                          },
                        );
                      },
                    ),
                  ),

                //Occupation & Gender
                Row(
                  children: [
                    Expanded(
                      child: ValueListenableBuilder<String?>(
                        valueListenable: _selectSex,
                        builder: (BuildContext context, String? sexSelect, Widget? child) {
                          return CustomDropdownFormField(
                            value: sexSelect,
                            hintText: 'Gender',
                            items: StaticList.sexList,
                            onChanged: (value) {
                              if (value != null) {
                                _selectSex.value = value;
                              }
                            },
                            validator: (value) {
                              if (value == null) {
                                return ErrorString.genderErr;
                              }
                              return null;
                            },
                          );
                        },
                      ),
                    ),
                    10.horizontalSpace,
                    if (widget.selectedRole == "Doctor")
                      Expanded(
                        child: ValueListenableBuilder<String?>(
                          valueListenable: _selectOccupations,
                          builder: (BuildContext context, String? occupationSelect, Widget? child) {
                            return CustomDropdownFormField(
                              value: occupationSelect,
                              hintText: 'Occupations',
                              items: StaticList.occupations,
                              onChanged: (value) {
                                if (value != null) {
                                  _selectOccupations.value = value;
                                }
                              },
                              validator: (value) {
                                if (value == null) {
                                  return ErrorString.occupationErr;
                                }
                                return null;
                              },
                            );
                          },
                        ),
                      )
                    else
                      Expanded(
                        child: ValueListenableBuilder<String?>(
                          valueListenable: _selectBlood,
                          builder: (BuildContext context, String? bloodSelect, Widget? child) {
                            return CustomDropdownFormField(
                              value: bloodSelect,
                              hintText: 'Blood Group',
                              items: StaticList.bloodGroup,
                              onChanged: (value) {
                                if (value != null) {
                                  _selectBlood.value = value;
                                }
                              },
                              validator: (value) {
                                if (value == null) {
                                  return ErrorString.bloodErr;
                                }
                                return null;
                              },
                            );
                          },
                        ),
                      ),
                  ],
                ),

                //Doctor Type
                if (widget.selectedRole == "Doctor")
                  Padding(
                    padding: EdgeInsets.only(bottom: 7.sp),
                    child: ValueListenableBuilder<String?>(
                      valueListenable: _selectType,
                      builder: (BuildContext context, String? typeSelect, Widget? child) {
                        return CustomDropdownFormField(
                          value: typeSelect,
                          hintText: 'Doctor Type',
                          items: StaticList.doctorType,
                          onChanged: (value) {
                            if (value != null) {
                              _selectType.value = value;
                            }
                          },
                          validator: (value) {
                            if (value == null) {
                              return ErrorString.doctorTypeErr;
                            }
                            return null;
                          },
                        );
                      },
                    ),
                  ),

                //Experience & Age
                Row(
                  children: [
                    if (widget.selectedRole == "Doctor" || widget.selectedRole == "Technician")
                      Expanded(
                        child: CustomTextField(
                          label: LabelString.labelExperience,
                          hintText: LabelString.labelExperience,
                          controller: experienceCtrl,
                          textInputType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return ErrorString.experienceErr;
                            }
                            return null;
                          },
                        ),
                      ),
                    if (widget.selectedRole == "Doctor" || widget.selectedRole == "Technician") 10.horizontalSpace,
                    Expanded(
                      child: CustomTextField(
                        label: LabelString.labelAge,
                        hintText: LabelString.labelAge,
                        controller: ageCtrl,
                        textInputType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return ErrorString.ageErr;
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),

                //password
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
                14.verticalSpace,

                CustomButton(
                  onPressed: () {
                    _registerUser();
                  },
                  text: "${LabelString.labelRegister} Now",
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }

  void _registerUser() {
    if (_formKey.currentState!.validate()) {
      createUserRequest.name = nameCtrl.text;
      createUserRequest.email = emailCtrl.text.trim();
      createUserRequest.phone = phoneCtrl.text;
      createUserRequest.password = passCtrl.text;
      createUserRequest.role = widget.selectedRole;
      createUserRequest.sex = _selectSex.value;
      createUserRequest.age = int.parse(ageCtrl.text.trim());

      // Role-specific fields
      switch (widget.selectedRole) {
        case 'Doctor':
          createUserRequest.hospital = _selectHospital.value?.name.toString();
          createUserRequest.occupation = _selectOccupations.value;
          createUserRequest.experience = int.parse(experienceCtrl.text.trim());
          createUserRequest.type = _selectType.value;
          break;

        case 'Patient':
          createUserRequest.blood = _selectBlood.value;
          break;

        case 'Technician':
          createUserRequest.experience = int.parse(experienceCtrl.text.trim());
          createUserRequest.blood = _selectBlood.value;
          break;

        default:
          print('Unknown role: ${widget.selectedRole}');
          return;
      }

      // Single event for all user types
      authBloc.add(CreateUserEvent(createUserRequest));
      debugPrint(createUserRequest.toJson().toString());
    }
  }
}
