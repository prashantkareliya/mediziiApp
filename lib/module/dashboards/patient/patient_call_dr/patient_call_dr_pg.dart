import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medizii/components/custom_appbar.dart';
import 'package:medizii/components/custom_loader.dart';
import 'package:medizii/components/cutom_textfield.dart';
import 'package:medizii/constants/app_colours/app_colors.dart';
import 'package:medizii/constants/fonts/font_weight.dart';
import 'package:medizii/constants/helpers.dart';
import 'package:medizii/constants/strings.dart';
import 'package:medizii/gen/assets.gen.dart';
import 'package:medizii/module/dashboards/patient/bloc/patient_bloc.dart';
import 'package:medizii/module/dashboards/patient/data/patient_datasource.dart';
import 'package:medizii/module/dashboards/patient/data/patient_repository.dart';
import 'package:medizii/module/dashboards/patient/model/get_all_doctor_response.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class PatientCallDrPage extends StatefulWidget {
  PatientCallDrPage({super.key});

  @override
  State<PatientCallDrPage> createState() => _PatientCallDrPageState();
}

class _PatientCallDrPageState extends State<PatientCallDrPage> {
  String selectedSpecialty = 'Cardiologist';


  TextEditingController searchController = TextEditingController();
  final ValueNotifier<String> selectedSpecialtyNotifier = ValueNotifier<String>('Cardiologist');

  bool showSpinner = false;
  GetAllDoctorResponse? doctorResponse;
  List<DoctorData>? doctors = [];
  List<String>? doctorsTypes = [];
  List<DoctorData>? filteredDoctors = [];

  PatientBloc patientBloc = PatientBloc(PatientRepository(patientDatasource: PatientDatasource()));

  @override
  void initState() {
    super.initState();
    patientBloc.add(GetAllDoctorEvent());
  }

  void filterDoctorsByType(String type) {
    setState(() {
      filteredDoctors = doctors?.where((doctor) => doctor.type == type).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CustomAppBar(
        title: LabelString.labelCallDoctor,
        isNotification: true,
      ),
      body: BlocConsumer<PatientBloc, PatientState>(
        bloc: patientBloc,
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
            doctorResponse = state.data;
            if (doctorResponse != null) {
              doctors = doctorResponse?.doctorData;
              doctorsTypes = doctors!.map((doc) => doc.type.toString()).toSet().toList();
              filterDoctorsByType(selectedSpecialtyNotifier.value);
            }
          }
        },
        builder: (context, state) {
          return ModalProgressHUD(
            blur: 2.0,
            inAsyncCall: showSpinner,
            progressIndicator: CustomLoader(),
            child: Padding(
              padding: EdgeInsets.all(16.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    LabelString.labelLookingDoctor,
                    style: GoogleFonts.dmSans(color: AppColors.redColor, fontSize: 22.sp, fontWeight: GoogleFontWeight.semiBold),
                  ),
                  4.verticalSpace,
                  CustomTextField(
                    label: "",
                    controller: searchController,
                    suffixIcon: Padding(
                      padding: EdgeInsets.all(12.sp),
                      child: Assets.icIcons.search.svg(colorFilter: ColorFilter.mode(AppColors.redColor, BlendMode.srcIn)),
                    ),
                    hintText: LabelString.labelSearchHint,
                  ),
                  4.verticalSpace,

                  SizedBox(
                    height: 32.sp,
                    child: ValueListenableBuilder<String>(
                      valueListenable: selectedSpecialtyNotifier,
                      builder: (context, selectedSpecialty, child) {
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: doctorsTypes?.length ?? 0,
                          itemBuilder: (context, index) {
                            bool isSelected = doctorsTypes?[index] == selectedSpecialty;
                            return GestureDetector(
                              onTap: () {
                                selectedSpecialtyNotifier.value = doctorsTypes![index];
                                final selectedType = doctorsTypes![index];
                                selectedSpecialtyNotifier.value = selectedType;
                                filterDoctorsByType(selectedType);
                              },
                              child: Container(
                                margin: EdgeInsets.only(right: 12.sp),
                                padding: EdgeInsets.symmetric(horizontal: 14.sp),
                                decoration: BoxDecoration(
                                  color: isSelected ? AppColors.blueColor.withValues(alpha: 0.1) : AppColors.whiteColor,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: isSelected ? AppColors.transparent : AppColors.gray.withValues(alpha: 0.2)),
                                ),
                                child: Center(
                                  child: Text(
                                    doctorsTypes?[index] ?? "",
                                    style: GoogleFonts.dmSans(
                                      color: isSelected ? AppColors.blueColor : AppColors.blackColor,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                  12.verticalSpace,
                  Expanded(
                    child: ListView.builder(
                      itemCount: filteredDoctors?.length ?? 0,
                      itemBuilder: (context, index) {
                        return DoctorCard(doctor: filteredDoctors?[index]);
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class DoctorCard extends StatelessWidget {
  DoctorData? doctor;

  DoctorCard({Key? key, this.doctor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.sp),
      padding: EdgeInsets.all(13.sp),
      decoration: BoxDecoration(
        color: AppColors.greyBg,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10, offset: Offset(0, 2))],
      ),
      child: Row(
        children: [
          Container(
            width: 50.sp,
            height: 50.sp,
              decoration: BoxDecoration(shape: BoxShape.circle),
              child: Image.asset("assets/images/profile.png")
          ),
          13.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(doctor?.name ?? "",
                    style: GoogleFonts.dmSans(fontSize: 14.sp, fontWeight: FontWeight.bold, color: AppColors.blackColor)),
                2.verticalSpace,
                Text(doctor?.type ?? "", style: GoogleFonts.dmSans(fontSize: 12.sp, color: AppColors.gray)),
              ],
            ),
          ),

          Row(
            children: [
              GestureDetector(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Calling ${doctor?.name ?? ""}...')));
                },
                child: Container(
                  decoration: BoxDecoration(color: AppColors.whiteColor, shape: BoxShape.circle),
                  padding: EdgeInsets.all(6.sp),
                  child: Assets.icIcons.call.svg(colorFilter: ColorFilter.mode(AppColors.redColor, BlendMode.srcIn)),
                ),
              ),
              10.horizontalSpace,
              GestureDetector(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Starting video call with ${doctor?.name}...')));
                },
                child: Container(
                  decoration: BoxDecoration(color: AppColors.whiteColor, shape: BoxShape.circle),
                  padding: EdgeInsets.all(6.sp),
                  child: Assets.icIcons.video.svg(colorFilter: ColorFilter.mode(AppColors.redColor, BlendMode.srcIn)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
