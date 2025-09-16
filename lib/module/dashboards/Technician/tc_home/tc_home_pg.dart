import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medizii/components/custom_loading_wrapper.dart';
import 'package:medizii/components/no_data_screen.dart';
import 'package:medizii/components/sharedPreferences_service.dart';
import 'package:medizii/constants/app_colours/app_colors.dart';
import 'package:medizii/constants/helpers.dart';
import 'package:medizii/constants/strings.dart';
import 'package:medizii/gen/assets.gen.dart';
import 'package:medizii/module/dashboards/Technician/bloc/technician_bloc.dart';
import 'package:medizii/module/dashboards/Technician/data/technician_datasource.dart';
import 'package:medizii/module/dashboards/Technician/data/technician_repository.dart';
import 'package:medizii/module/dashboards/patient/model/get_ride_history_response.dart';

class TechnicianHomePage extends StatefulWidget {
  const TechnicianHomePage({super.key});

  @override
  State<TechnicianHomePage> createState() => _TechnicianHomePageState();
}

class _TechnicianHomePageState extends State<TechnicianHomePage> {
  final prefs = PreferenceService().prefs;

  TechnicianBloc technicianBloc = TechnicianBloc(TechnicianRepository(technicianDatasource: TechnicianDatasource()));
  bool showSpinner = false;
  GetRideHistoryResponse? getRideHistoryResponse;
  List<RideHistory>? rides;

  String? pickLocation;


  @override
  void initState() {
    super.initState();
    technicianBloc.add(GetRideHistoryEvent(prefs.getString(PreferenceString.prefsUserId).toString()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/technician_bg.png"), fit: BoxFit.fill)),
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
                      decoration: BoxDecoration(color: Colors.white12, borderRadius: BorderRadius.circular(25)),
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
                Text(prefs.getString(PreferenceString.prefsName) ?? "",
                    style: GoogleFonts.dmSans(color: AppColors.whiteColor, fontSize: 24.sp, fontWeight: FontWeight.w600)),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.fromLTRB(18.sp, 10.sp, 18.sp, 5.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    LabelString.labelActiveRide,
                    style: GoogleFonts.dmSans(color: AppColors.blackColor, fontSize: 14.sp, fontWeight: FontWeight.w700),
                  ),
                  7.verticalSpace,
                  //Assets.images.noRide.image(),
                  Container(
                      width: double.infinity,
                      padding: EdgeInsets.fromLTRB(18.sp, 10.sp, 18.sp, 10.sp),
                      decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: const Color(0xFFFF6B6B), width: 2),
                        boxShadow: [
                          BoxShadow(color: Colors.grey.withValues(alpha: 0.1), spreadRadius: 2, blurRadius: 10, offset: const Offset(0, 5)),
                        ],
                      ),
                      child: /*Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Pickup Row
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Pickup icon & line
                            Column(
                              children: [
                                Assets.icIcons.location1.svg(colorFilter: ColorFilter.mode(AppColors.blueColor, BlendMode.srcIn)),
                                DottedLine(
                                  direction: Axis.vertical,
                                  lineLength: 0.035.sh,
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
                                      Text(LabelString.labelDistance, style: GoogleFonts.dmSans(fontSize: 12.sp, color: AppColors.gray)),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "96966 Amalia Green, NY",
                                          style: GoogleFonts.dmSans(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                                        ),
                                      ),
                                      Text(
                                        "12km",
                                        style: GoogleFonts.dmSans(fontSize: 12.sp, fontWeight: FontWeight.bold, color: AppColors.redColor),
                                      ),
                                    ],
                                  ),
                                  12.verticalSpace,
                                  Text(LabelString.labelDropLocation, style: GoogleFonts.dmSans(fontSize: 12.sp, color: AppColors.gray)),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "ABC Hospital",
                                        style: GoogleFonts.dmSans(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(8.sp),
                                        decoration: BoxDecoration(color: AppColors.iconBgColor, borderRadius: BorderRadius.circular(25)),
                                        child: Assets.icIcons.location.svg(
                                          colorFilter: ColorFilter.mode(AppColors.redColor, BlendMode.srcIn),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        16.verticalSpace,
                        GestureDetector(
                          onTap: () {
                            showDialog(context: context, builder: (context) => TechnicianNewRequestDialog());
                          },
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(color: AppColors.grey, width: 1),
                            ),
                            child: Center(
                              child: Text(
                                LabelString.labelViewDetail,
                                style: GoogleFonts.dmSans(fontSize: 16.sp, fontWeight: FontWeight.w600, color: AppColors.redColor),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),*/
                      Assets.images.noActiveRide.image()
                  ),
                  20.verticalSpace,
                  Text(
                    LabelString.labelHistory,
                    style: GoogleFonts.dmSans(color: AppColors.blackColor, fontSize: 14.sp, fontWeight: FontWeight.w700),
                  ),
                  7.verticalSpace,
                  BlocConsumer<TechnicianBloc, TechnicianState>(
                    bloc: technicianBloc,
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
                      return Expanded(
                        child: LoadingWrapper(
                          showSpinner: showSpinner,
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
                                            Assets.icIcons.location1.svg(
                                                colorFilter: ColorFilter.mode(AppColors.blueColor, BlendMode.srcIn)),
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
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


String calculateDistance(RideHistory rid) {
  double distanceInMeters = Geolocator.distanceBetween(
      rid.patientLocation!.coordinates![0].toDouble(),
      rid.patientLocation!.coordinates![1].toDouble(),
      rid.destinationLocation!.coordinates![0].toDouble(),
      rid.destinationLocation!.coordinates![1].toDouble()
  );

  double distanceInKm = distanceInMeters / 1000;
  print('Distance: ${distanceInKm.toStringAsFixed(2)} km');
  return distanceInKm.toStringAsFixed(2);
}

class AddressTextWidget extends StatelessWidget {
  final double latitude;
  final double longitude;

  AddressTextWidget({required this.latitude, required this.longitude});

  Future<String> getAddressFromLatLng(double longitude, double latitude) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);
      if (placemarks.isNotEmpty) {
        final placemark = placemarks.first;

        String address = "${placemark.street}, "
            "${placemark.locality}, "
            "${placemark.administrativeArea}, "
            "${placemark.country}";
        return address;
      } else {
        return "No address available";
      }
    } catch (e) {
      print(e);
      return "Error getting address";
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: getAddressFromLatLng(longitude, latitude),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text(
            "Loading address...",
            style: GoogleFonts.dmSans(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          );
        } else if (snapshot.hasError) {
          return Text(
            "Failed to get address",
            style: GoogleFonts.dmSans(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          );
        } else {
          return Text(
            snapshot.data ?? "No address found",
            style: GoogleFonts.dmSans(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          );
        }
      },
    );
  }
}
