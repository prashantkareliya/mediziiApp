import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:medizii/components/custom_loading_wrapper.dart';
import 'package:medizii/constants/app_colours/app_colors.dart';
import 'package:medizii/constants/helpers.dart';
import 'package:medizii/constants/strings.dart';
import 'package:medizii/gen/assets.gen.dart';
import 'package:medizii/module/dashboards/patient/model/ems_booking_response.dart';
import 'package:medizii/module/dashboards/patient/patient_book_ems/pt_confirm_location_pg.dart';


class PatientDrawMapPage extends StatefulWidget {
  LatLangForDrawMap? langForDrawMap;
  PatientDrawMapPage(this.langForDrawMap, {super.key});

  @override
  State<PatientDrawMapPage> createState() => _PatientDrawMapPageState();
}

class _PatientDrawMapPageState extends State<PatientDrawMapPage> {
  GoogleMapController? _mapController;

  Set<Polyline> _polylines = {};
  Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _setMarkersAndPolyline();
    _calculateDistance();

  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  void _setMarkersAndPolyline() {
    _markers.add(
      Marker(
        markerId: MarkerId('start'),
        position: LatLng(widget.langForDrawMap!.startLat!.toDouble(), widget.langForDrawMap!.startLang!.toDouble()),
        infoWindow: InfoWindow(title: 'Patient'),
      ),
    );

    _markers.add(
      Marker(
        markerId: MarkerId('end'),
        position: LatLng(widget.langForDrawMap!.endLang!.toDouble(), widget.langForDrawMap!.endLat!.toDouble()),
        infoWindow: InfoWindow(title: 'Hospital'),

      ),
    );

    // Add polyline
    _polylines.add(
      Polyline(
        polylineId: PolylineId('customRoute'),
        jointType: JointType.round,

        points: [
          LatLng(widget.langForDrawMap!.startLat!.toDouble(), widget.langForDrawMap!.startLang!.toDouble()),
          LatLng(widget.langForDrawMap!.endLang!.toDouble(), widget.langForDrawMap!.endLat!.toDouble()),
        ],
        color: Colors.red,
        width: 4,
      ),
    );
  }

  void _calculateDistance() {
    double distanceInMeters = Geolocator.distanceBetween(
      widget.langForDrawMap!.startLat!.toDouble(),
      widget.langForDrawMap!.startLang!.toDouble(),
      widget.langForDrawMap!.endLang!.toDouble(),
      widget.langForDrawMap!.endLat!.toDouble(),
    );

    double distanceInKm = distanceInMeters / 1000;
    print('Distance: ${distanceInKm.toStringAsFixed(2)} km');
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoadingWrapper(
        showSpinner: false,
        child: Stack(
          fit: StackFit.expand,
          children: [
            GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: LatLng(widget.langForDrawMap!.startLat!.toDouble(), widget.langForDrawMap!.startLang!.toDouble()),
                zoom: 11.0,
              ),
              markers: _markers,
              polylines: _polylines,
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(12.sp, 30.sp, 12.sp, 18.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      padding: EdgeInsets.only(left: 8.sp, right: 0, top: 12.sp, bottom: 12.sp),
                      decoration: BoxDecoration(color: AppColors.greyBg, shape: BoxShape.circle),
                      child: Icon(Icons.arrow_back_ios, color: AppColors.blackColor),
                    ),
                  ),
                  Spacer(),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 18.sp, vertical: 9.sp),
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: const Color(0xFFFF6B6B), width: 2),
                      boxShadow: [
                        BoxShadow(color: Colors.grey.withOpacity(0.1), spreadRadius: 2, blurRadius: 10, offset: const Offset(0, 5)),
                      ],
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Ambulance On \nThe Way',
                              style: GoogleFonts.dmSans(fontSize: 18.sp, fontWeight: FontWeight.w600, color: AppColors.blackColor),
                            ),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Helpers.startCall(" ");
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(8.sp),
                                    decoration: BoxDecoration(color: AppColors.iconBgColor, borderRadius: BorderRadius.circular(25)),
                                    child: Assets.icIcons.call.svg(colorFilter: ColorFilter.mode(AppColors.redColor, BlendMode.srcIn)),
                                  ),
                                ),
                                10.horizontalSpace,
                                Container(
                                  padding: EdgeInsets.all(8.sp),
                                  decoration: BoxDecoration(color: AppColors.iconBgColor, borderRadius: BorderRadius.circular(25)),
                                  child: Assets.icIcons.location.svg(colorFilter: ColorFilter.mode(AppColors.redColor, BlendMode.srcIn)),
                                ),
                              ],
                            ),
                          ],
                        ),
                        8.verticalSpace,
                        Row(
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
                            12.horizontalSpace,
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Prashant K",
                                  style: GoogleFonts.dmSans(fontSize: 12.sp, fontWeight: FontWeight.bold, color: AppColors.blackColor),
                                ),
                                Text(
                                  '★ ★ ★ ★ ★',
                                  style: GoogleFonts.dmSans(fontSize: 12.sp, fontWeight: FontWeight.bold, color: Color(0XFFEE9F25)),
                                ),
                              ],
                            ),
                          ],
                        ),
                        8.verticalSpace,

                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10.sp, vertical: 5.sp),
                          decoration: BoxDecoration(color: AppColors.greyBg, borderRadius: BorderRadius.circular(12)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(LabelString.labelArrivedAt, style: GoogleFonts.dmSans(fontSize: 14.sp, color: AppColors.gray)),
                                  Text(
                                    '8:30 PM',
                                    style: GoogleFonts.dmSans(fontSize: 18.sp, fontWeight: FontWeight.bold, color: AppColors.blackColor),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(LabelString.labelVehicleNo, style: GoogleFonts.dmSans(fontSize: 14.sp, color: AppColors.gray)),
                                  Text(
                                    'KA 05 f 4214',
                                    style: GoogleFonts.dmSans(fontSize: 18.sp, fontWeight: FontWeight.bold, color: AppColors.blackColor),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        10.verticalSpace,
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
