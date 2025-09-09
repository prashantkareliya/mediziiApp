import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medizii/components/context_extension.dart';
import 'package:medizii/components/custom_appbar.dart';
import 'package:medizii/components/custom_button.dart';
import 'package:medizii/components/custom_loader.dart';
import 'package:medizii/components/cutom_textfield.dart';
import 'package:medizii/components/sharedPreferences_service.dart';
import 'package:medizii/constants/app_colours/app_colors.dart';
import 'package:medizii/constants/helpers.dart';
import 'package:medizii/constants/strings.dart';
import 'package:medizii/main.dart';
import 'package:medizii/module/dashboards/doctor/bloc/doctor_bloc.dart';
import 'package:medizii/module/dashboards/doctor/bloc/doctor_event.dart';
import 'package:medizii/module/dashboards/doctor/data/doctor_datasource.dart';
import 'package:medizii/module/dashboards/doctor/data/doctor_repository.dart';
import 'package:medizii/module/dashboards/doctor/model/get_doctor_by_id_response.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../../components/custom_loading_wrapper.dart';

class DoctorProfilePage extends StatefulWidget {
  const DoctorProfilePage({super.key});

  @override
  State<DoctorProfilePage> createState() => _DoctorProfilePageState();
}

class _DoctorProfilePageState extends State<DoctorProfilePage> {
  final prefs = PreferenceService().prefs;

  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController phoneCtrl = TextEditingController();

  DoctorBloc doctorBloc = DoctorBloc(DoctorRepository(doctorDatasource: DoctorDatasource()));
  bool showSpinner = false;
  GetDoctorByIdResponse? getDoctorByIdResponse;

  @override
  void initState() {
    super.initState();
    _callApi();
  }

  _callApi() {
    doctorBloc.add(GetDoctorByIdEvent(prefs.getString(PreferenceString.prefsUserId).toString()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CustomAppBar(title: LabelString.labelProfile, isBack: true),
      body: BlocConsumer<DoctorBloc, DoctorState>(
        bloc: doctorBloc,
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
            getDoctorByIdResponse = state.data;
            if (getDoctorByIdResponse != null) {
              nameCtrl.text = getDoctorByIdResponse?.drData?.name ?? "";
              emailCtrl.text = getDoctorByIdResponse?.drData?.email ?? "";
              phoneCtrl.text = getDoctorByIdResponse?.drData?.phone ?? "";
            }
          }
        },
        builder: (context, state) {
          return LoadingWrapper(
            showSpinner: showSpinner,
            child: Padding(
              padding: EdgeInsets.all(18.sp),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: 110.h,
                      width: 110.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(image: AssetImage("assets/images/profile.png"), fit: BoxFit.cover),
                      ),
                      child: Align(
                        alignment: Alignment(1.2, 1.2),
                        child: Container(
                          padding: EdgeInsets.all(5.0),
                          decoration: BoxDecoration(color: AppColors.greyBg, shape: BoxShape.circle),
                          child: Icon(Icons.edit),
                        ),
                      ),
                    ),
                    40.verticalSpace,
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
                      readOnly: true,
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
                      readOnly: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return ErrorString.emailAddressErr;
                        }
                        return null;
                      },
                    ),
                    20.verticalSpace,
                    CustomButton(
                      onPressed: () {
                        navigationService.pop();
                      },
                      text: LabelString.labelUpdate,
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
