import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medizii/components/custom_appbar.dart';
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
import 'package:medizii/module/dashboards/Technician/tc_patient/tc_summery_detail_pg.dart';
import 'package:medizii/module/dashboards/doctor/bloc/doctor_bloc.dart';
import 'package:medizii/module/dashboards/doctor/bloc/doctor_event.dart';
import 'package:medizii/module/dashboards/doctor/data/doctor_datasource.dart';
import 'package:medizii/module/dashboards/doctor/data/doctor_repository.dart';
import 'package:medizii/module/dashboards/doctor/dr_patient/dr_patient_pg.dart';
import 'package:medizii/module/dashboards/doctor/model/get_all_doctor_response.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';


class TechnicianPatientPage extends StatefulWidget {
  const TechnicianPatientPage({super.key});

  @override
  State<TechnicianPatientPage> createState() => _TechnicianPatientPageState();
}

class _TechnicianPatientPageState extends State<TechnicianPatientPage> {
  TextEditingController searchController = TextEditingController();

  final prefs = PreferenceService().prefs;

  DoctorBloc doctorBloc = DoctorBloc(DoctorRepository(doctorDatasource: DoctorDatasource()));
  bool showSpinner = false;
  GetAllPatientResponse? patientResponse;
  List<PatientData>? patients = [];
  final debounce = Debounce(milliseconds: 800);
  Key _gridKey = UniqueKey();

  @override
  void initState() {
    super.initState();
    doctorBloc.add(GetAllPatientEvent(name: searchController.text));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CustomAppBar(title: LabelString.labelPatient, rightWidget: null),

      body: Padding(
        padding: EdgeInsets.fromLTRB(18.sp, 0.sp, 18.sp, 18.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            8.verticalSpace,
            Text(
              LabelString.labelSearchPatient,
              style: GoogleFonts.dmSans(fontSize: 18.sp, fontWeight: GoogleFontWeight.semiBold, color: AppColors.redColor),
            ),
            4.verticalSpace,
            CustomTextField(
              label: "",
              controller: searchController,
              suffixIcon: Padding(
                padding: EdgeInsets.all(12.sp),
                child: Assets.icIcons.search.svg(colorFilter: ColorFilter.mode(AppColors.redColor, BlendMode.srcIn)),
              ),
              hintText: LabelString.labelSearchPatient,
              onChange: (value) {
                debounce.run(() {
                  setState(() {
                    _gridKey = UniqueKey(); // Forces GridView to rebuild
                  });
                  doctorBloc.add(GetAllPatientEvent(name: searchController.text));
                });
              },
            ),
            8.verticalSpace,
            BlocConsumer<DoctorBloc, DoctorState>(
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
                  patientResponse = state.data;
                  if (patientResponse != null) {
                    patients = patientResponse?.patientData;
                  }
                }
              },
              builder: (context, state) {
                return Expanded(
                  child: LoadingWrapper(
                    showSpinner: showSpinner,
                    child: GridView.builder(
                      key: _gridKey,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 10.sp,
                        mainAxisSpacing: 10.sp,
                        childAspectRatio: 0.8,
                      ),
                      itemCount: patients?.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            navigationService.push(TechnicianSummeryDetailPg(patients?[index].sId));
                          },
                          child: Column(
                            children: [
                              ClipOval(child: Image.network("https://i.pravatar.cc/150?img=2", height: 80, width: 80, fit: BoxFit.cover)),
                              8.verticalSpace,
                              Text(
                                patients?[index].name ?? "",
                                style: GoogleFonts.dmSans(fontSize: 12.sp, fontWeight: FontWeight.w500, color: AppColors.blackColor),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
