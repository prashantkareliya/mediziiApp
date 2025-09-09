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
import 'package:medizii/module/dashboards/patient/bloc/patient_bloc.dart';
import 'package:medizii/module/dashboards/patient/data/patient_datasource.dart';
import 'package:medizii/module/dashboards/patient/data/patient_repository.dart';
import 'package:medizii/module/dashboards/patient/model/upload_report_request.dart';
import 'package:medizii/module/dashboards/patient/patient_home/pt_medical_report_dialog.dart';

class PtReportsUploadPage extends StatefulWidget {
  const PtReportsUploadPage({super.key});

  @override
  State<PtReportsUploadPage> createState() => _PtReportsUploadPageState();
}

class _PtReportsUploadPageState extends State<PtReportsUploadPage> {
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
          UploadReportImagesEvent(prefs.getString(PreferenceString.prefsUserId).toString(), uploadReportRequest));
    }
  }
}

class FileItem extends StatelessWidget {
  final String fileName;
  final String fileSize;
  final String uploadDate;
  final Color iconColor;
  final IconData icon;

  const FileItem({
    Key? key,
    required this.fileName,
    required this.fileSize,
    required this.uploadDate,
    required this.iconColor,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18.sp, vertical: 14.sp),
      margin: EdgeInsets.symmetric(vertical: 5.sp),
      decoration: BoxDecoration(
        color: AppColors.greyBg,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 8, offset: const Offset(0, 2))],
      ),
      child: Row(
        children: [
          Container(
            width: 50.sp,
            height: 50.sp,
            padding: EdgeInsets.all(8.sp),
            decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.whiteColor),
            child: Assets.icIcons.pdf.svg(colorFilter: ColorFilter.mode(AppColors.redColor, BlendMode.srcIn)),
          ),
          14.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(fileName, style: GoogleFonts.dmSans(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black87)),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Expanded(child: Text(fileSize, style: GoogleFonts.dmSans(fontSize: 14, color: Colors.grey[600]))),
                    Text(' • ', style: GoogleFonts.dmSans(fontSize: 14, color: Colors.grey[600])),
                    Expanded(child: Text(uploadDate, style: GoogleFonts.dmSans(fontSize: 14, color: Colors.grey[600]))),
                  ],
                ),
              ],
            ),
          ),
          Container(
            width: 40.sp,
            height: 40.sp,
            padding: EdgeInsets.all(8.sp),
            decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(8)),
            child: Assets.icIcons.delete.svg(colorFilter: ColorFilter.mode(AppColors.gray, BlendMode.srcIn)),
          ),
        ],
      ),
    );
  }
}


bool isImageFile(String path) {
  final ext = path.toLowerCase();
  return ext.endsWith('.jpg') || ext.endsWith('.jpeg') ||
      ext.endsWith('.png') || ext.endsWith('.gif') ||
      ext.endsWith('.bmp') || ext.endsWith('.webp');
}


/*import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medizii/components/custom_appbar.dart';
import 'package:medizii/components/custom_button.dart';
import 'package:medizii/components/custom_document_picker.dart';
import 'package:medizii/components/custom_loading_wrapper.dart';
import 'package:medizii/components/fullscreen_image.dart';
import 'package:medizii/components/sharedPreferences_service.dart';
import 'package:medizii/constants/app_colours/app_colors.dart';
import 'package:medizii/constants/helpers.dart';
import 'package:medizii/constants/strings.dart';
import 'package:medizii/gen/assets.gen.dart';
import 'package:medizii/main.dart';
import 'package:medizii/module/dashboards/patient/bloc/patient_bloc.dart';
import 'package:medizii/module/dashboards/patient/data/patient_datasource.dart';
import 'package:medizii/module/dashboards/patient/data/patient_repository.dart';
import 'package:medizii/module/dashboards/patient/model/upload_report_request.dart';
import 'package:medizii/module/dashboards/patient/patient_home/pt_medical_report_dialog.dart';
import 'package:open_filex/open_filex.dart';

class PtReportsUploadPage extends StatefulWidget {
  const PtReportsUploadPage({super.key});

  @override
  State<PtReportsUploadPage> createState() => _PtReportsUploadPageState();
}

class _PtReportsUploadPageState extends State<PtReportsUploadPage> {
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
                          // Debug

                          print("!!!!!!!!!!!!!!!!!Picked file path: $pickedFilePaths");
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
                      child: _buildUploadPlaceholder() /*Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 30.sp, vertical: 20.sp),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      //border: Border.all(color: AppColors.blueColor, width: 1),
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: 60.sp,
                          height: 60.sp,
                          decoration: BoxDecoration(color: Colors.blue.withValues(alpha: 0.1), shape: BoxShape.circle),
                          child: Padding(
                            padding: EdgeInsets.all(15.sp),
                            child: Assets.icIcons.upload.svg(colorFilter: ColorFilter.mode(AppColors.blueColor, BlendMode.srcIn)),
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
                        Text(
                          'Supported Format: JPG, PNG, PDF\n(Max 10mb)',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.dmSans(fontSize: 14.sp, color: AppColors.gray),
                        ),
                      ],
                    ),
                  ),*/,
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
                            icon: Icons.picture_as_pdf,
                          ),
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

  /*Widget _buildPickedImagesGrid(List<String> paths) {
    List<Widget> fileWidgets = paths.map((path) {
      final isImage = isImageFile(path);
      final fileName = path
          .split('/')
          .last;

      return GestureDetector(
        onTap: () {
          if (isImage) {
            navigationService.push(FullScreenImageViewer(imagePath: path));
          } else {
            OpenFilex.open(path);
          }
        },
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.all(5.sp),
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.grey.shade100
                ),
                child: isImage
                    ? ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.file(File(path), fit: BoxFit.cover))
                    : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.picture_as_pdf, color: Colors.red, size: 30),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: Text(
                          fileName, maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 10),
                          textAlign: TextAlign.center),
                    ),
                  ],
                ),
              ),
            ),
            // Delete icon
            Positioned(
              top: 4,
              right: 4,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    pickedFilePaths.remove(path);
                  });
                },
                child: Container(
                  decoration: BoxDecoration(color: Colors.black54, shape: BoxShape.circle),
                  padding: EdgeInsets.all(4),
                  child: Icon(Icons.close, size: 14, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      );
    }).toList();

    fileWidgets.add(
      GestureDetector(
        onTap: () {
          showFilePickerBottomSheet(
            context: context,
            onFilesPicked: (List<String> newPaths) {
              setState(() {
                pickedFilePaths.addAll(newPaths);
                uploadApiCall(pickedFilePaths);
              });

            },
          );
        },
        child: Padding(
          padding: EdgeInsets.all(5.sp),
          child: Container(width: 80, height: 80,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
                color: Colors.white),
            child: Center(child: Icon(Icons.add, color: Colors.grey, size: 30)),
          ),
        ),
      ),
    );

    return Wrap(spacing: 10, runSpacing: 10, children: fileWidgets);
  }*/

  void uploadApiCall(List<String> pickedFilePaths) {
    for (var path in pickedFilePaths) {
      UploadReportRequest uploadReportRequest = UploadReportRequest(files: path);
      patientBloc.add(
          UploadReportImagesEvent(prefs.getString(PreferenceString.prefsUserId).toString(), uploadReportRequest));
    }
  }
}

class FileItem extends StatelessWidget {
  final String fileName;
  final String fileSize;
  final String uploadDate;
  final Color iconColor;
  final IconData icon;

  const FileItem({
    Key? key,
    required this.fileName,
    required this.fileSize,
    required this.uploadDate,
    required this.iconColor,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18.sp, vertical: 14.sp),
      margin: EdgeInsets.symmetric(vertical: 5.sp),
      decoration: BoxDecoration(
        color: AppColors.greyBg,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 8, offset: const Offset(0, 2))],
      ),
      child: Row(
        children: [
          Container(
            width: 50.sp,
            height: 50.sp,
            padding: EdgeInsets.all(8.sp),
            decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.whiteColor),
            child: Assets.icIcons.pdf.svg(colorFilter: ColorFilter.mode(AppColors.redColor, BlendMode.srcIn)),
          ),
          14.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(fileName, style: GoogleFonts.dmSans(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black87)),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Expanded(child: Text(fileSize, style: GoogleFonts.dmSans(fontSize: 14, color: Colors.grey[600]))),
                    Text(' • ', style: GoogleFonts.dmSans(fontSize: 14, color: Colors.grey[600])),
                    Expanded(child: Text(uploadDate, style: GoogleFonts.dmSans(fontSize: 14, color: Colors.grey[600]))),
                  ],
                ),
              ],
            ),
          ),
          Container(
            width: 40.sp,
            height: 40.sp,
            padding: EdgeInsets.all(8.sp),
            decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(8)),
            child: Assets.icIcons.delete.svg(colorFilter: ColorFilter.mode(AppColors.gray, BlendMode.srcIn)),
          ),
        ],
      ),
    );
  }
}


bool isImageFile(String path) {
  final ext = path.toLowerCase();
  return ext.endsWith('.jpg') || ext.endsWith('.jpeg') || ext.endsWith('.png') || ext.endsWith('.gif') || ext.endsWith('.bmp') ||
      ext.endsWith('.webp');
}*/
