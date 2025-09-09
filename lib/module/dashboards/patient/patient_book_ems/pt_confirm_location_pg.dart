import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:medizii/components/context_extension.dart';
import 'package:medizii/components/custom_button.dart';
import 'package:medizii/components/cutom_textfield.dart';
import 'package:medizii/components/sharedPreferences_service.dart';
import 'package:medizii/constants/app_colours/app_colors.dart';
import 'package:medizii/constants/fonts/font_weight.dart';
import 'package:medizii/constants/helpers.dart';
import 'package:medizii/constants/strings.dart';
import 'package:medizii/gen/assets.gen.dart';
import 'package:medizii/main.dart';
import 'package:medizii/module/authentication/bloc/auth_bloc.dart';
import 'package:medizii/module/authentication/bloc/auth_event.dart';
import 'package:medizii/module/authentication/bloc/auth_state.dart';
import 'package:medizii/module/authentication/data/datasource.dart';
import 'package:medizii/module/authentication/data/repository.dart';
import 'package:medizii/module/authentication/model/hospitals_response.dart';
import 'package:medizii/module/authentication/model/nearest_hospital_response.dart';

import '../../../../components/custom_loading_wrapper.dart';

class PtConfirmLocationPage extends StatefulWidget {
  const PtConfirmLocationPage({super.key});

  @override
  State<PtConfirmLocationPage> createState() => _PtConfirmLocationPageState();
}

class _PtConfirmLocationPageState extends State<PtConfirmLocationPage> {
  final prefs = PreferenceService().prefs;

  TextEditingController pickLocationController = TextEditingController();
  TextEditingController dropLocationController = TextEditingController();

  AuthBloc authBloc = AuthBloc(AuthRepository(authDatasource: AuthDatasource()));
  bool showSpinner = false;

  HospitalResponse? hospitalResponse;
  List<HospitalData>? hospitalList;

  GetNearestHospitalResponse? nearestHospitalResponse;
  List<NearestHospitals>? nearestHospital;


  GoogleMapController? mapController;
  final Set<Marker> _markers = {};
  Set<Marker> newMarkers = {};
  LatLng? _currentPosition;
  String? _currentLat;
  String? _currentLang;


  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _openBottomSheet();
    });
    authBloc.add(FetchHospitalsEvent());
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.deniedForever || permission == LocationPermission.denied) {
      return;
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      _currentPosition = LatLng(position.latitude, position.longitude);
      _currentLat = position.latitude.toString();
      _currentLang = position.longitude.toString();
    });
    String address = await getAddressFromLatLng(position.latitude, position.longitude);
    print(address);
    pickLocationController.text = address;
  }

  Future<String> getAddressFromLatLng(double latitude, double longitude) async {
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
  void dispose() {
    pickLocationController.dispose();
    dropLocationController.dispose();
    mapController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: BlocConsumer<AuthBloc, AuthState>(
        bloc: authBloc,
        listener: (context, state) async {
          if (state is FailureState) {
            showSpinner = false;
            Helpers.showSnackBar(context, state.error);
          }
          if (state is LoadingState) {
            showSpinner = true;
          }
          if (state is LoadedState) {
            showSpinner = false;

            if (state.data is HospitalResponse) {
              hospitalResponse = state.data;
              hospitalList = hospitalResponse?.data;

              for (var hospital in hospitalList!) {
                final coordinates = hospital.location?.coordinates;
                final LatLng position = LatLng(coordinates![1], coordinates[0]); // [lng, lat]
                final String name = hospital.name ?? "";
                final String address = hospital.address ?? "";

                _markers.add(
                  Marker(
                      markerId: MarkerId(hospital.sId ?? ""),
                      position: position,
                      infoWindow: InfoWindow(title: name, snippet: address),
                      icon: await BitmapDescriptor.fromAssetImage(
                        const ImageConfiguration(size: Size(15, 15),),
                        'assets/ic_icons/ic_hospital.png',
                      )
                  ),
                );
                /* mapController?.animateCamera(
                  CameraUpdate.newCameraPosition(
                    CameraPosition(
                      target: _currentPosition ?? LatLng(28.6139, 77.2090),
                      zoom: 12,
                    ),
                  ),
                );*/
              }
            } else {
              nearestHospitalResponse = state.data;
              nearestHospital = nearestHospitalResponse?.nearestHospitals;

              for (var hospital in nearestHospital!) {
                final coordinates = hospital.location?.coordinates;
                final LatLng position = LatLng(coordinates![1], coordinates[0]);
                final String name = hospital.name ?? "";
                final String address = hospital.address ?? "";

                final marker = Marker(
                  markerId: MarkerId(hospital.name ?? UniqueKey().toString()),
                  position: position,
                  infoWindow: InfoWindow(title: name, snippet: address),
                  icon: await BitmapDescriptor.fromAssetImage(
                    const ImageConfiguration(size: Size(15, 15)),
                    'assets/ic_icons/ic_hospital.png',
                  ),
                );
                newMarkers.add(marker);
              }

              setState(() {
                _markers.clear();
                _markers.addAll(newMarkers);

                if (newMarkers.isNotEmpty) {
                  mapController?.animateCamera(
                    CameraUpdate.newLatLngZoom(newMarkers.first.position, 10),
                  );
                }
              });
            }
          }
        },
        builder: (context, state) {
          return LoadingWrapper(
            showSpinner: showSpinner,
            child: Stack(
              fit: StackFit.expand,
              children: [
                GoogleMap(
                    onMapCreated: _onMapCreated,
                    initialCameraPosition: CameraPosition(
                        target: _currentPosition ?? LatLng(28.6139, 77.2090),
                        zoom: 10.0
                    ),
                    markers: _markers,
                    myLocationEnabled: true,
                    myLocationButtonEnabled: true
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(18.sp, 30.sp, 18.sp, 18.sp),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: Container(
                            padding: EdgeInsets.only(left: 8.sp, right: 0, top: 12.sp, bottom: 12.sp),
                            decoration: BoxDecoration(
                                color: AppColors.greyBg,
                                shape: BoxShape.circle
                            ),
                            child: Icon(Icons.arrow_back_ios, color: AppColors.blackColor)),
                      ),
                      Spacer(),
                      Center(
                        child: CustomButton(
                          width: context.width() * 0.7,
                          onPressed: () {
                            _openBottomSheet();
                          },
                          text: LabelString.labelBookEms,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),

      // bottomSheet: SelectAddressBottomSheet(),
    );
  }

  _openBottomSheet() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(bottom: MediaQuery
                .of(context)
                .viewInsets
                .bottom),
            child: Container(
              height: context.height() * 0.45,
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(color: AppColors.greyBg, borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: Text(
                      LabelString.labelSelectAddress,
                      style: GoogleFonts.dmSans(color: AppColors.redColor, fontSize: 18.sp, fontWeight: GoogleFontWeight.semiBold),
                    ),
                  ),
                  20.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Assets.icIcons.location1.svg(colorFilter: ColorFilter.mode(AppColors.blueColor, BlendMode.srcIn)),
                          DottedLine(
                            direction: Axis.vertical,
                            lineLength: 0.073.sh,
                            lineThickness: 1.5,
                            dashLength: 6.0,
                            dashColor: Colors.black,
                            dashGapLength: 1.5,
                          ),
                          Assets.icIcons.location.svg(colorFilter: ColorFilter.mode(AppColors.redColor, BlendMode.srcIn)),
                        ],
                      ),
                      12.horizontalSpace,
                      Expanded(
                        child: Column(
                          children: [
                            CustomTextField(
                              maxLine: 1,
                              label: LabelString.labelPickupLocation,
                              controller: pickLocationController,
                              hintText: LabelString.labelEnterPickupLocation,
                              suffixIcon: Padding(padding: EdgeInsets.all(8.sp), child: Assets.icIcons.location.svg()),
                            ),
                            10.horizontalSpace,
                            Column(
                              children: [
                                CustomTextField(
                                  maxLine: 1,
                                  label: LabelString.labelDropLocation,
                                  controller: dropLocationController,
                                  hintText: LabelString.labelEnterDropLocation,
                                ),
                                3.verticalSpace,
                                GestureDetector(
                                  onTap: () {
                                    authBloc.add(NearestHospitalEvent(lat: "77.2043418", lang: "28.5686110"));
                                  },
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      LabelString.labelNearbyHospital,
                                      style: GoogleFonts.dmSans(color: AppColors.blueColor, fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            15.verticalSpace,
                          ],
                        ),
                      ),
                    ],
                  ),
                  CustomButton(onPressed: () {
                    navigationService.pop();
                  }, text: LabelString.labelConfirmLocation),
                ],
              ),
            ),
          );
        }
    );
  }
}