import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medizii/components/custom_appbar.dart';
import 'package:medizii/components/custom_button.dart';
import 'package:medizii/components/custom_dropdown_field.dart';
import 'package:medizii/components/custom_loading_wrapper.dart';
import 'package:medizii/components/cutom_textfield.dart';
import 'package:medizii/components/sharedPreferences_service.dart';
import 'package:medizii/constants/app_colours/app_colors.dart';
import 'package:medizii/constants/helpers.dart';
import 'package:medizii/constants/strings.dart';
import 'package:medizii/main.dart';
import 'package:medizii/module/dashboards/patient/bloc/patient_bloc.dart';
import 'package:medizii/module/dashboards/patient/data/patient_datasource.dart';
import 'package:medizii/module/dashboards/patient/data/patient_repository.dart';
import 'package:medizii/module/dashboards/patient/model/ems_booking_detail_request.dart';
import 'package:medizii/module/dashboards/patient/model/ems_booking_request.dart';
import 'package:medizii/module/dashboards/patient/model/ems_booking_response.dart';
import 'package:medizii/module/dashboards/patient/model/get_booking_detail_response.dart';
import 'package:medizii/module/dashboards/patient/patient_book_ems/pt_confirm_location_pg.dart';
import 'package:medizii/module/dashboards/patient/patient_book_ems/pt_draw_map_pg.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class PatientBookEmsFormPage extends StatefulWidget {
  LatLangForDrawMap? langForDrawMap;

  PatientBookEmsFormPage(this.langForDrawMap, {super.key});

  @override
  State<PatientBookEmsFormPage> createState() => _PatientBookEmsFormPageState();
}

class _PatientBookEmsFormPageState extends State<PatientBookEmsFormPage> {
  final prefs = PreferenceService().prefs;
  final _formKey = GlobalKey<FormState>();
  String? fcmToken;
  late final ValueNotifier<String?> _selectEmsType = ValueNotifier<String?>(null);
  late final ValueNotifier<String?> _selectReason = ValueNotifier<String?>(null);
  TextEditingController timeController = TextEditingController();
  TextEditingController nameCtrl = TextEditingController();
  TextEditingController phoneCtrl = TextEditingController();

  final ValueNotifier<String> selectedReasonNotifier = ValueNotifier<String>('');

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(context: context, initialTime: TimeOfDay.now());

    if (pickedTime != null) {
      final formattedTime = pickedTime.format(context);
      setState(() {
        timeController.text = formattedTime;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    nameCtrl.text = (prefs.getString(PreferenceString.prefsName) ?? "").toString();
    phoneCtrl.text = (prefs.getString(PreferenceString.prefsPhone) ?? "").toString();
    initFcmAndSocket();
  }

  PatientBloc patientBloc = PatientBloc(PatientRepository(patientDatasource: PatientDatasource()));
  bool showSpinner = false;

  EmsBookingResponse? emsBookingResponse;
  GetBookingDetailResponse? getBookingDetailResponse;

  late IO.Socket socket;

  Future<void> initFcmAndSocket() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission();
    fcmToken = await messaging.getToken();
    print("FCM token: $fcmToken");

    socket = IO.io("https://medizii.onrender.com", <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': true,
    });

    socket.onConnect((_) {
      print("Socket connected: ${socket.id}");
      socket.emit("patient_online", {"patientId": prefs.getString(PreferenceString.prefsUserId), "device_token": fcmToken});
    });

    socket.on("booking_confirmed", (data) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(data['message'] ?? "Ambulance confirmed 🚑")));
      if (data != null) {
        GetBookingDetailRequest getBookingDetailRequest = GetBookingDetailRequest(bookingId: emsBookingResponse?.bookingId);
        patientBloc.add(BookingDetailEvent(getBookingDetailRequest));
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Message clicked!: ${message.data}');
      final bookingId = message.data['patientId'];
    });
  }

  @override
  void dispose() {
    socket.dispose();
    socket.disconnected;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CustomAppBar(title: LabelString.labelBookEms, isNotification: false, isBack: true),
      body: BlocConsumer<PatientBloc, PatientState>(
        bloc: patientBloc,
        listener: (context, state) async {
          if (state is FailureState) {
            showSpinner = false;
            Helpers.showSnackBar(context, state.error);
          }
          if (state is LoadingState) {
            showSpinner = true;
          }
          if (state is LoadedState) {
            if (state.data is GetBookingDetailResponse) {
              showSpinner = false;
              getBookingDetailResponse = state.data;
              navigationService.push(PatientDrawMapPage(getBookingDetailResponse));
            } else {
              emsBookingResponse = state.data;
              Helpers.showSnackBar(context, emsBookingResponse?.message ?? "");
            }
          }
        },
        builder: (context, state) {
          return LoadingWrapper(
            showSpinner: showSpinner,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.sp),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    20.verticalSpace,
                    ValueListenableBuilder<String?>(
                      valueListenable: _selectEmsType,
                      builder: (BuildContext context, String? emsSelect, Widget? child) {
                        return Column(
                          children: [
                            CustomDropdownFormField(
                              label: LabelString.labelEmsType,
                              value: emsSelect,
                              hintText: 'Select ambulance type',
                              items: StaticList.ambulanceTypes,
                              onChanged: (value) {
                                if (value != null) {
                                  _selectEmsType.value = value;
                                }
                              },
                              validator: (value) {
                                if (value == null) {
                                  return ErrorString.emsErr;
                                }
                                return null;
                              },
                            ),
                          ],
                        );
                      },
                    ),

                    CustomTextField(
                      label: LabelString.labelPickupTime,
                      hintText: LabelString.labelPickupTime,
                      controller: timeController,
                      suffixIcon: Icon(Icons.watch_later, color: AppColors.redColor),
                      onTap: () => _selectTime(context),
                      readOnly: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return ErrorString.pickTimeErr;
                        }
                        return null;
                      },
                    ),

                    ValueListenableBuilder<String?>(
                      valueListenable: _selectReason,
                      builder: (BuildContext context, String? reasonSelect, Widget? child) {
                        return CustomDropdownFormField(
                          label: LabelString.labelReason,
                          value: reasonSelect,
                          hintText: LabelString.labelSelectReason,
                          items: StaticList.emergencyHealthReasons,
                          onChanged: (value) {
                            if (value != null) {
                              _selectReason.value = value;
                            }
                          },
                          validator: (value) {
                            if (value == null) {
                              return ErrorString.reasonErr;
                            }
                            return null;
                          },
                        );
                      },
                    ),
                    CustomTextField(
                      label: LabelString.labelFullName,
                      hintText: LabelString.labelEnterName,
                      controller: nameCtrl,
                      textInputType: TextInputType.name,
                      readOnly: true,
                    ),
                    7.verticalSpace,
                    CustomTextField(
                      label: LabelString.labelPhoneNumber,
                      hintText: LabelString.labelEnterPhoneNumber,
                      controller: phoneCtrl,
                      textInputType: TextInputType.number,
                      readOnly: true,
                    ),
                    Spacer(),
                    CustomButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {

                        }
                        callApi();
                      },
                      text: LabelString.labelBookNow,
                    ),
                    15.verticalSpace,
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void callApi() {
    EmsBookingRequest emsBookingRequest = EmsBookingRequest(
      patientId: prefs.getString(PreferenceString.prefsUserId),
      lat: widget.langForDrawMap?.startLat.toString(),
      lng: widget.langForDrawMap?.startLang.toString(),
      destLat: widget.langForDrawMap?.endLat.toString(),
      destLng: widget.langForDrawMap?.endLang.toString(),
      deviceToken: fcmToken ?? "",
      deviceType: Platform.isAndroid ? "android" : "ios",
    );
    patientBloc.add(EmsBookingEvent(emsBookingRequest));
  }
}
