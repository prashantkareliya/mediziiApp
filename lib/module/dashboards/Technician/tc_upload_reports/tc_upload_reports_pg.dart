import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medizii/components/custom_appbar.dart';
import 'package:medizii/components/custom_document_picker.dart';
import 'package:medizii/components/custom_loading_wrapper.dart';
import 'package:medizii/components/sharedPreferences_service.dart';
import 'package:medizii/constants/app_colours/app_colors.dart';
import 'package:medizii/constants/helpers.dart';
import 'package:medizii/constants/strings.dart';
import 'package:medizii/gen/assets.gen.dart';
import 'package:medizii/module/dashboards/doctor/model/get_all_doctor_response.dart';
import 'package:medizii/module/dashboards/patient/bloc/patient_bloc.dart';
import 'package:medizii/module/dashboards/patient/data/patient_datasource.dart';
import 'package:medizii/module/dashboards/patient/data/patient_repository.dart';
import 'package:medizii/module/dashboards/patient/model/upload_report_request.dart';
import 'package:medizii/module/dashboards/patient/patient_home/pt_medical_report_dialog.dart';
import 'package:medizii/module/dashboards/patient/patient_home/pt_reposts_upload_pg.dart';

class TechnicianReportsUploadPage extends StatefulWidget {
  PatientData? patient;

  TechnicianReportsUploadPage(this.patient, {super.key});

  @override
  State<TechnicianReportsUploadPage> createState() => _TechnicianReportsUploadPageState();
}

class _TechnicianReportsUploadPageState extends State<TechnicianReportsUploadPage> {
  final prefs = PreferenceService().prefs;
  bool showSpinner = false;

  List<String> pickedFilePaths = [];
  PatientBloc patientBloc = PatientBloc(PatientRepository(patientDatasource: PatientDatasource()));


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CustomAppBar(title: LabelString.labelReports, isBack: true),
      body: Padding(
        padding: EdgeInsets.all(16.sp),
        child: BlocConsumer<PatientBloc, PatientState>(
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
              pickedFilePaths.clear();
            }
          },
          builder: (context, state) {
            return LoadingWrapper(
              showSpinner: showSpinner,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      showFilePickerBottomSheet(
                        context: context,
                        onFilesPicked: (List<String> paths) {
                          setState(() {
                            pickedFilePaths.addAll(paths);
                            uploadApiCall(pickedFilePaths);
                          });
                        },
                      );
                    },
                    child: DottedBorder(
                        options: RoundedRectDottedBorderOptions(
                          radius: Radius.circular(18.0),
                          dashPattern: [7, 4],
                          strokeWidth: 1.5,
                          color: AppColors.blueColor,
                        ),
                        child: _buildUploadPlaceholder()
                    ),
                  ),

                  28.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          LabelString.labelUploadedFiles,
                          style: GoogleFonts.dmSans(fontSize: 18.sp, fontWeight: FontWeight.w600, color: AppColors.blackColor)),
                      Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(color: AppColors.gray.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(25)),
                          child: Icon(Icons.swap_vert, color: AppColors.blackColor, size: 24)),
                    ],
                  ),
                  18.verticalSpace,

                  Expanded(
                    child: ListView.builder(
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return PtMedicalReportDialog();
                              },
                            );
                          },
                          child: FileItem(
                              fileName: 'X-Ray Report.pdf',
                              fileSize: '3 MB',
                              uploadDate: '25 Jan 2025',
                              iconColor: Colors.red,
                              icon: Icons.picture_as_pdf),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildUploadPlaceholder() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 18.sp),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(color: Colors.blue.withOpacity(0.1), shape: BoxShape.circle),
            child: Padding(
              padding: EdgeInsets.all(15.sp),
              child: Assets.icIcons.upload.svg(height: 40.sp,
                colorFilter: ColorFilter.mode(AppColors.blueColor, BlendMode.srcIn),
              ),
            ),
          ),
          15.verticalSpace,
          RichText(
            text: TextSpan(
              text: "Click here ",
              style: GoogleFonts.dmSans(fontSize: 16.sp, fontWeight: FontWeight.w700, color: AppColors.blackColor),
              children: [
                TextSpan(
                  text: 'to upload your file',
                  style: GoogleFonts.dmSans(fontSize: 16.sp, fontWeight: FontWeight.w500, color: Colors.black87),
                ),
              ],
            ),
          ),
          6.verticalSpace,
          Text('Supported Format: JPG, PNG, PDF\n(Max 10mb)',
            textAlign: TextAlign.center,
            style: GoogleFonts.dmSans(fontSize: 14.sp, color: AppColors.gray),
          ),
        ],
      ),
    );
  }

  void uploadApiCall(List<String> pickedFilePaths) {
    for (var path in pickedFilePaths) {
      UploadReportRequest uploadReportRequest = UploadReportRequest(files: path);
      patientBloc.add(
          UploadReportImagesEvent(widget.patient!.sId.toString(), uploadReportRequest));
    }
  }
}

