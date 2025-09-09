import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medizii/components/custom_loader.dart';
import 'package:medizii/constants/app_colours/app_colors.dart';
import 'package:medizii/constants/helpers.dart';
import 'package:medizii/constants/strings.dart';
import 'package:medizii/gen/assets.gen.dart';
import 'package:medizii/module/dashboards/doctor/bloc/doctor_bloc.dart';
import 'package:medizii/module/dashboards/doctor/bloc/doctor_event.dart';
import 'package:medizii/module/dashboards/doctor/data/doctor_datasource.dart';
import 'package:medizii/module/dashboards/doctor/data/doctor_repository.dart';
import 'package:medizii/module/dashboards/doctor/model/get_patient_detail.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../components/custom_appbar.dart';
import '../../../../components/custom_loading_wrapper.dart';

class TechnicianSummeryDetailPg extends StatefulWidget {
  String? sId;
  TechnicianSummeryDetailPg(this.sId, {super.key});

  @override
  State<TechnicianSummeryDetailPg> createState() => _TechnicianSummeryDetailPgState();
}

class _TechnicianSummeryDetailPgState extends State<TechnicianSummeryDetailPg> {

  DoctorBloc doctorBloc = DoctorBloc(DoctorRepository(doctorDatasource: DoctorDatasource()));
  bool showSpinner = false;

  GetAllPatientDetailResponse? patientDetail;

  @override
  void initState() {
    super.initState();
    _callApi();
  }

  _callApi() {
    doctorBloc.add(GetPatientByIdEvent(widget.sId.toString()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CustomAppBar(
        title: LabelString.labelPatientsSummary,
        rightWidget: Row(
          children: [
            GestureDetector(
              onTap: () async {
                makePhoneCall("+91${patientDetail?.patientDetailData?.phone ?? ""}");
              },
              child: Container(
                decoration: BoxDecoration(color: AppColors.greyBg, shape: BoxShape.circle),
                padding: EdgeInsets.all(6.sp),
                child: Assets.icIcons.call.svg(colorFilter: ColorFilter.mode(AppColors.redColor, BlendMode.srcIn)),
              ),
            ),
            10.horizontalSpace,
            GestureDetector(
              onTap: () {},
              child: Container(
                decoration: BoxDecoration(color: AppColors.greyBg, shape: BoxShape.circle),
                padding: EdgeInsets.all(6.sp),
                child: Assets.icIcons.video.svg(colorFilter: ColorFilter.mode(AppColors.redColor, BlendMode.srcIn)),
              ),
            ),
          ],
        ),
        isBack: true,
      ),
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
            patientDetail = state.data;
          }
        },
        builder: (context, state) {
          return LoadingWrapper(
            showSpinner: showSpinner,
            child: SingleChildScrollView(
              padding: EdgeInsets.all(23.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(16.sp),
                    decoration: BoxDecoration(color: AppColors.greyBg, borderRadius: BorderRadius.circular(16)),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.network(
                            "https://inboundhealth.com/wp-content/uploads/iStock-1473155464.jpg",
                            width: 80.sp,
                            height: 80.sp,
                            fit: BoxFit.cover,
                          ),
                        ),
                        16.horizontalSpace,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              patientDetail?.patientDetailData?.name ?? "",
                              style: GoogleFonts.dmSans(fontSize: 18.sp, fontWeight: FontWeight.w600, color: AppColors.blackColor),
                            ),
                            4.verticalSpace,
                            Row(
                              children: [
                                Text(
                                  "ID: ${patientDetail?.patientDetailData?.iV ?? ""}",
                                  style: GoogleFonts.dmSans(fontSize: 14.sp, color: AppColors.gray),
                                ),
                                8.horizontalSpace,
                                const Text("•", style: TextStyle(color: AppColors.red)),
                                8.horizontalSpace,
                                Text("25 Jan 2025", style: GoogleFonts.dmSans(fontSize: 14.sp, color: AppColors.gray)),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  16.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildInfoCard("Sex", patientDetail?.patientDetailData?.sex ?? ""),
                      _buildInfoCard("Age", (patientDetail?.patientDetailData?.age ?? "").toString()),
                      _buildInfoCard("Blood", patientDetail?.patientDetailData?.blood ?? ""),
                    ],
                  ),
                  16.verticalSpace,
                  _buildExpandableCard(
                    title: "About",
                    content:
                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since. Lorem Ipsum is simply dummy text.",
                  ),
                  12.verticalSpace,
                  _buildExpandableCard(title: "Reports", content: "Reports content goes here..."),
                  12.verticalSpace,
                  _buildExpandableCard(title: "Lorem Ipsum", content: "Lorem Ipsum content goes here..."),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildInfoCard(String label, String value) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 4.sp),
        padding: EdgeInsets.all(14.sp),
        decoration: BoxDecoration(color: AppColors.greyBg, borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: GoogleFonts.dmSans(fontSize: 14.sp, color: AppColors.gray)),
            4.verticalSpace,
            Text(value, style: GoogleFonts.dmSans(fontSize: 16.sp, fontWeight: FontWeight.bold, color: AppColors.black)),
          ],
        ),
      ),
    );
  }

  // Expandable Card Widget
  Widget _buildExpandableCard({required String title, required String content}) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(color: AppColors.greyBg, borderRadius: BorderRadius.circular(12)),
      child: ExpansionTile(
        tilePadding: EdgeInsets.symmetric(horizontal: 16.sp),
        childrenPadding: EdgeInsets.fromLTRB(16.sp, 0.sp, 16.sp, 10.sp),
        title: Text(title, style: GoogleFonts.dmSans(fontSize: 16.sp, fontWeight: FontWeight.bold, color: AppColors.blackColor)),
        iconColor: AppColors.red,
        collapsedIconColor: AppColors.red,
        children: [Text(content, style: GoogleFonts.dmSans(fontSize: 14.sp, color: AppColors.gray))],
      ),
    );
  }

  canLaunchUrl(phoneUri) {}

  void makePhoneCall(String phoneNumber) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);

    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    } else {
      throw 'Could not launch $phoneUri';
    }
  }
}
