import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medizii/components/custom_appbar.dart';
import 'package:medizii/components/custom_loading_wrapper.dart';
import 'package:medizii/components/cutom_textfield.dart';
import 'package:medizii/components/no_data_screen.dart';
import 'package:medizii/components/sharedPreferences_service.dart';
import 'package:medizii/constants/app_colours/app_colors.dart';
import 'package:medizii/constants/fonts/font_weight.dart';
import 'package:medizii/constants/helpers.dart';
import 'package:medizii/constants/strings.dart';
import 'package:medizii/gen/assets.gen.dart';
import 'package:medizii/main.dart';
import 'package:medizii/module/dashboards/doctor/bloc/doctor_bloc.dart';
import 'package:medizii/module/dashboards/doctor/bloc/doctor_event.dart';
import 'package:medizii/module/dashboards/doctor/data/doctor_datasource.dart';
import 'package:medizii/module/dashboards/doctor/data/doctor_repository.dart';
import 'package:medizii/module/dashboards/doctor/dr_patient/dr_patient_pg.dart';
import 'package:medizii/module/dashboards/doctor/dr_upload_reports/dr_upload_reports_pg.dart';
import 'package:medizii/module/dashboards/doctor/model/get_all_doctor_response.dart';

import 'tc_upload_reports_pg.dart';

class TechnicianSearchPatientPage extends StatefulWidget {
  const TechnicianSearchPatientPage({super.key});

  @override
  State<TechnicianSearchPatientPage> createState() => _TechnicianSearchPatientPageState();
}

class _TechnicianSearchPatientPageState extends State<TechnicianSearchPatientPage> {
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
    //doctorBloc.add(GetAllPatientEvent(name: searchController.text));
  }

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: LabelString.labelUploadReport),
      body: Padding(
        padding: EdgeInsets.fromLTRB(18.sp, 8.sp, 18.sp, 18.sp),
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
                  doctorBloc.add(GetAllPatientEvent(name: searchController.text));
                  setState(() {
                    _gridKey = UniqueKey(); // Forces GridView to rebuild
                  });
                });
              },
            ),
            16.verticalSpace,
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
                  child:LoadingWrapper(
                    showSpinner: showSpinner,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: searchController.text.isEmpty ? NoDataScreen(textString: "Search Patient & \nupload document") : ListView.separated(
                            itemCount: patients?.length ?? 0,
                            separatorBuilder: (_, __) => 12.verticalSpace,
                            itemBuilder: (context, index) {
                              final patient = patients?[index];
                              return GestureDetector(
                                onTap: () {
                                  navigationService.push(TechnicianReportsUploadPage(patient));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.greyBg,
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: [
                                      BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 8, offset: const Offset(0, 2))
                                    ],
                                  ),
                                  child: ListTile(
                                    contentPadding: EdgeInsets.symmetric(horizontal: 12.sp, vertical: 8.sp),
                                    leading: ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: Image.network("https://i.pravatar.cc/150?img=1", height: 45.sp, width: 45.sp, fit: BoxFit.cover),
                                    ),
                                    title: Text(patient?.name ?? "", style: GoogleFonts.dmSans(fontSize: 16.sp, fontWeight: FontWeight.w500)),
                                    subtitle: Row(
                                      children: [
                                        Text("Blood: ${patient?.blood ?? ""}",
                                            style: GoogleFonts.dmSans(fontSize: 12.sp, color: Colors.black54)),
                                        6.horizontalSpace,
                                        Text("•", style: TextStyle(color: Colors.red, fontSize: 12.sp)),
                                        6.horizontalSpace,
                                        Text("Age: ${patient?.age ?? ""}", style: GoogleFonts.dmSans(fontSize: 12.sp, color: Colors.black54)),
                                      ],
                                    ),
                                    trailing: Container(
                                      padding: EdgeInsets.all(4.sp),
                                      decoration: BoxDecoration(color: AppColors.whiteColor, shape: BoxShape.circle),
                                      child: Icon(Icons.arrow_forward_ios_rounded, color: AppColors.redColor),
                                    ),
                                  ),
                                ),
                              );
                            },
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
      ),
    );
  }
}
