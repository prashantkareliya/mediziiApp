import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medizii/components/context_extension.dart';
import 'package:medizii/components/custom_appbar.dart';
import 'package:medizii/components/custom_button.dart';
import 'package:medizii/components/custom_loader.dart';
import 'package:medizii/components/custom_loading_wrapper.dart';
import 'package:medizii/components/no_data_screen.dart';
import 'package:medizii/components/sharedPreferences_service.dart';
import 'package:medizii/constants/app_colours/app_colors.dart';
import 'package:medizii/constants/helpers.dart';
import 'package:medizii/constants/strings.dart';
import 'package:medizii/gen/assets.gen.dart';
import 'package:medizii/main.dart';
import 'package:medizii/module/dashboards/Technician/tc_home/tc_home_pg.dart';
import 'package:medizii/module/dashboards/patient/bloc/patient_bloc.dart';
import 'package:medizii/module/dashboards/patient/data/patient_datasource.dart';
import 'package:medizii/module/dashboards/patient/data/patient_repository.dart';
import 'package:medizii/module/dashboards/patient/model/get_ride_history_response.dart';

import 'pt_confirm_location_pg.dart';

class PatientBookEmsPage extends StatefulWidget {
  const PatientBookEmsPage({super.key});

  @override
  State<PatientBookEmsPage> createState() => _PatientBookEmsPageState();
}

class _PatientBookEmsPageState extends State<PatientBookEmsPage> {
  String selectedOption = 'Others'; // Default selection
  final ValueNotifier<bool> isForSelf = ValueNotifier<bool>(false);
  final ValueNotifier<bool> isForOthers = ValueNotifier<bool>(true);
  final prefs = PreferenceService().prefs;

  PatientBloc patientBloc = PatientBloc(PatientRepository(patientDatasource: PatientDatasource()));
  bool showSpinner = false;
  GetRideHistoryResponse? getRideHistoryResponse;
  List<RideHistory>? rides;

  @override
  void dispose() {
    isForSelf.dispose();
    isForOthers.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    patientBloc.add(GetRideHistoryEvent(prefs.getString(PreferenceString.prefsUserId).toString()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CustomAppBar(
        title: LabelString.labelCallEms,
        isNotification: false,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.sp),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            15.verticalSpace,
            GestureDetector(
              onTap: () {
                isForSelf.value = true;
                isForOthers.value = false;
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 14.sp, vertical: 14.sp),
                decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(14.r)),
                child: Row(
                  children: [
                    ValueListenableBuilder<bool>(
                      valueListenable: isForSelf,
                      builder: (context, value, child) {
                        return Container(
                          width: 35.sp,
                          height: 35.sp,
                          decoration: BoxDecoration(color: value ? AppColors.redColor : AppColors.greyBg, shape: BoxShape.circle),
                          padding: EdgeInsets.all(5.sp),
                          child: Assets.icIcons.single.svg(
                            colorFilter: ColorFilter.mode(value ? AppColors.whiteColor : AppColors.blackColor, BlendMode.srcIn),
                          ),
                        );
                      },
                    ),
                    20.horizontalSpace,
                    Text(
                      LabelString.labelYourself,
                      style: GoogleFonts.dmSans(fontSize: 16.sp, fontWeight: FontWeight.w500, color: AppColors.blackColor),
                    ),
                    Spacer(),
                    ValueListenableBuilder<bool>(
                      valueListenable: isForSelf,
                      builder: (context, value, child) {
                        return value
                            ? Container(
                          width: 20.sp,
                          height: 20.sp,
                          decoration: BoxDecoration(
                            color: AppColors.blueColor,
                            shape: BoxShape.circle,
                            border: Border.all(color: AppColors.greyBg, width: 2),
                          ),
                          child: Icon(Icons.check, color: Colors.white, size: 16.sp),
                        )
                            : const SizedBox.shrink();
                      },
                    ),
                  ],
                ),
              ),
            ),
            15.verticalSpace,
            GestureDetector(
              onTap: () {
                isForSelf.value = false;
                isForOthers.value = true;
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 14.sp, vertical: 14.sp),
                decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(14.r)),

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ValueListenableBuilder<bool>(
                      valueListenable: isForOthers,
                      builder: (context, value, child) {
                        return Container(
                          width: 35.sp,
                          height: 35.sp,
                          decoration: BoxDecoration(color: value ? AppColors.redColor : AppColors.greyBg, shape: BoxShape.circle),
                          padding: EdgeInsets.all(5.sp),
                          child: Assets.icIcons.group.svg(
                            colorFilter: ColorFilter.mode(value ? AppColors.whiteColor : AppColors.blackColor, BlendMode.srcIn),
                          ),
                        );
                      },
                    ),
                    20.horizontalSpace,
                    Text(
                      LabelString.labelOthers,
                      style: GoogleFonts.dmSans(fontSize: 16.sp, fontWeight: FontWeight.w500, color: AppColors.blackColor),
                    ),
                    Spacer(),
                    ValueListenableBuilder<bool>(
                      valueListenable: isForOthers,
                      builder: (context, value, child) {
                        return value
                            ? Container(
                          width: 20.sp,
                          height: 20.sp,
                          decoration: BoxDecoration(
                            color: AppColors.blueColor,
                            shape: BoxShape.circle,
                            border: Border.all(color: AppColors.greyBg, width: 2),
                          ),
                          child: Icon(Icons.check, color: Colors.white, size: 16.sp),
                        )
                            : const SizedBox.shrink();
                      },
                    ),
                  ],
                ),
              ),
            ),
            20.verticalSpace,
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                LabelString.labelHistory,
                style: GoogleFonts.dmSans(color: AppColors.blackColor, fontSize: 14.sp, fontWeight: FontWeight.w700),
              ),
            ),
            7.verticalSpace,
            BlocConsumer<PatientBloc, PatientState>(
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
                  getRideHistoryResponse = state.data;
                  rides = getRideHistoryResponse?.technician?.rideHistory;
                }
              },
              builder: (context, state) {
                return showSpinner ? CustomLoader() : Expanded(
                  child: ListView.separated(
                    dragStartBehavior: DragStartBehavior.start,
                    physics: BouncingScrollPhysics(),
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: rides?.length ?? 0,
                    itemBuilder: (context, index) {
                      return (rides ?? []).isEmpty ? NoDataScreen(textString: "No rides \ndata available") : Container(
                        width: double.infinity,
                        padding: EdgeInsets.fromLTRB(18.sp, 10.sp, 18.sp, 10.sp),
                        decoration: BoxDecoration(
                          color: AppColors.greyBg,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withValues(alpha: 0.1),
                              spreadRadius: 2,
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  children: [
                                    Assets.icIcons.location1.svg(colorFilter: ColorFilter.mode(AppColors.blueColor, BlendMode.srcIn)),
                                    DottedLine(
                                      direction: Axis.vertical,
                                      lineLength: 0.036.sh,
                                      lineThickness: 1.5,
                                      dashLength: 6.0,
                                      dashColor: Colors.black,
                                      dashGapLength: 1.5,
                                    ),
                                    Assets.icIcons.location.svg(colorFilter: ColorFilter.mode(AppColors.redColor, BlendMode.srcIn)),
                                  ],
                                ),
                                const SizedBox(width: 12),
                                // Location details
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      // Pickup
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            LabelString.labelPickupLocation,
                                            style: GoogleFonts.dmSans(fontSize: 12.sp, color: AppColors.gray),
                                          ),
                                          Text(
                                            LabelString.labelDistance,
                                            style: GoogleFonts.dmSans(fontSize: 12.sp, color: AppColors.gray),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: AddressTextWidget(
                                                latitude: rides![index].patientLocation!.coordinates![1],
                                                longitude: rides![index].patientLocation!.coordinates![0]),
                                          ),

                                          Text(
                                            "${calculateDistance(rides![index])} km",
                                            style: GoogleFonts.dmSans(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.redColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                      12.verticalSpace,
                                      Text(
                                        LabelString.labelDropLocation,
                                        style: GoogleFonts.dmSans(fontSize: 12.sp, color: AppColors.gray),
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          AddressTextWidget(
                                              latitude: rides![index].destinationLocation!.coordinates![1],
                                              longitude: rides![index].destinationLocation!.coordinates![0]),
                                          Container(
                                            padding: EdgeInsets.all(8.sp),
                                            decoration: BoxDecoration(
                                              color: AppColors.iconBgColor,
                                              borderRadius: BorderRadius.circular(25),
                                            ),
                                            child: Assets.icIcons.location.svg(
                                              colorFilter: ColorFilter.mode(AppColors.transparent, BlendMode.srcIn),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (_, __) => 20.verticalSpace,
                  ),
                );
              },
            ),
            Spacer(),
            CustomButton(
              width: context.width() * 0.7,
              onPressed: () {
                navigationService.push(PtConfirmLocationPage());
              },
              text: LabelString.labelNext,
            ),
          ],
        ),
      ),
    );
  }
}
