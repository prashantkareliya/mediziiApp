import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medizii/components/custom_loader.dart';
import 'package:medizii/components/custom_loading_wrapper.dart';
import 'package:medizii/components/sharedPreferences_service.dart';
import 'package:medizii/constants/app_colours/app_colors.dart';
import 'package:medizii/constants/helpers.dart';
import 'package:medizii/constants/strings.dart';
import 'package:medizii/gen/assets.gen.dart';
import 'package:medizii/main.dart';
import 'package:medizii/module/dashboards/doctor/bloc/doctor_bloc.dart';
import 'package:medizii/module/dashboards/doctor/bloc/doctor_event.dart';
import 'package:medizii/module/dashboards/doctor/data/doctor_datasource.dart';
import 'package:medizii/module/dashboards/doctor/data/doctor_repository.dart';
import 'package:medizii/module/dashboards/doctor/dr_home/dr_patient_detail_pg.dart';
import 'package:medizii/module/dashboards/doctor/model/get_all_doctor_response.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';


class DoctorHomePage extends StatefulWidget {
  const DoctorHomePage({super.key});

  @override
  State<DoctorHomePage> createState() => _DoctorHomePageState();
}

class _DoctorHomePageState extends State<DoctorHomePage> {
  final prefs = PreferenceService().prefs;

  DoctorBloc doctorBloc = DoctorBloc(DoctorRepository(doctorDatasource: DoctorDatasource()));
  bool showSpinner = false;
  GetAllPatientResponse? patientResponse;
  List<PatientData>? patients = [];

  @override
  void initState() {
    super.initState();
    doctorBloc.add(GetAllPatientEvent());
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/dr_home_bg.png"), fit: BoxFit.fill)),
            padding: EdgeInsets.symmetric(horizontal: 20.sp, vertical: 15.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                25.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 40.sp,
                      width: 40.sp,
                      decoration: BoxDecoration(
                        color: AppColors.whiteColor, // Border color
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.whiteColor, width: 2),
                        image: DecorationImage(
                          image: NetworkImage(
                            'https://www.careerstaff.com/wp-content/uploads/2024/04/how-to-improve-patient-experience-satisfaction-scores.jpg',
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.textSecondary.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Assets.icIcons.notification.svg(colorFilter: ColorFilter.mode(AppColors.whiteColor, BlendMode.srcIn)),
                    ),
                  ],
                ),
                20.verticalSpace,
                Text(
                  GreetingMessage.getGreetingMessage(),
                  style: GoogleFonts.dmSans(color: AppColors.whiteColor, fontSize: 14.sp, fontWeight: FontWeight.w400),
                ),
                3.verticalSpace,
                Text('Dr. ${prefs.getString(PreferenceString.prefsName)}', style: GoogleFonts.dmSans(color: AppColors.whiteColor, fontSize: 24.sp, fontWeight: FontWeight.w600)),
              ],
            ),
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
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.sp),
                        child: Text(LabelString.labelPatientsSummary,
                            style: GoogleFonts.dmSans(fontSize: 16.sp, fontWeight: FontWeight.w700, color: Colors.black87)),
                      ),
                      Expanded(
                        child: ListView.separated(
                          padding: EdgeInsets.fromLTRB(18.sp, 10.sp, 18.sp, 10.sp),
                          itemCount: patients?.length ?? 0,
                          separatorBuilder: (_, __) => 12.verticalSpace,
                          itemBuilder: (context, index) {
                            final patient = patients?[index];
                            return GestureDetector(
                              onTap: () {
                                navigationService.push(DoctorPatientDetailPg(patient?.sId));
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
    );
  }
}
