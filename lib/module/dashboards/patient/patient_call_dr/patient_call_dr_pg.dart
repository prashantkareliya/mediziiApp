import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medizii/components/custom_appbar.dart';
import 'package:medizii/components/cutom_textfield.dart';
import 'package:medizii/components/sharedPreferences_service.dart';
import 'package:medizii/constants/app_colours/app_colors.dart';
import 'package:medizii/constants/fonts/font_weight.dart';
import 'package:medizii/constants/helpers.dart';
import 'package:medizii/constants/strings.dart';
import 'package:medizii/gen/assets.gen.dart';
import 'package:medizii/module/dashboards/patient/bloc/patient_bloc.dart';
import 'package:medizii/module/dashboards/patient/data/patient_datasource.dart';
import 'package:medizii/module/dashboards/patient/data/patient_repository.dart';
import 'package:medizii/module/dashboards/patient/model/get_all_doctor_response.dart';

import '../../../../components/custom_loading_wrapper.dart';

class PatientCallDrPage extends StatefulWidget {
  PatientCallDrPage({super.key});

  @override
  State<PatientCallDrPage> createState() => _PatientCallDrPageState();
}

class _PatientCallDrPageState extends State<PatientCallDrPage> {
  String selectedSpecialty = 'Cardiologist';
  final prefs = PreferenceService().prefs;

  TextEditingController searchController = TextEditingController();
  final ValueNotifier<String> selectedSpecialtyNotifier = ValueNotifier<String>('Cardiologist');

  bool showSpinner = false;
  GetAllDoctorResponse? doctorResponse;
  List<DoctorData>? doctors = [];
  List<String>? doctorsTypes = [];
  List<DoctorData>? filteredDoctors = [];

  PatientBloc patientBloc = PatientBloc(PatientRepository(patientDatasource: PatientDatasource()));

  // Agora Configuration
  //static const String agoraAppId = AgoraString.agoraAppId;
  RtcEngine? _engine;

  @override
  void initState() {
    super.initState();
    patientBloc.add(GetAllDoctorEvent());
    // _initAgora();
  }

  @override
  void dispose() {
    _dispose();
    super.dispose();
  }

/*  Future<void> _initAgora() async {
    // Request permissions
    await [Permission.microphone, Permission.camera].request();

    // Create Agora engine
    _engine = createAgoraRtcEngine();
    await _engine!.initialize(RtcEngineContext(
      appId: agoraAppId,
      channelProfile: ChannelProfileType.channelProfileCommunication,
    ));

    // Enable video
    await _engine!.enableVideo();
    await _engine!.enableAudio();
  }*/

  Future<void> _dispose() async {
    await _engine?.leaveChannel();
    await _engine?.release();
  }


  // Generate channel name based on doctor and patient IDs
  /*String _generateChannelName(DoctorData doctor) {
    // You can customize this based on your requirements
    return "call_${doctor.sId}_${DateTime.now().millisecondsSinceEpoch}";
  }*/

  // Start Audio Call
  /*Future<void> _startAudioCall(DoctorData doctor) async {
    print("222222222222222 ---  ${doctor.sId}");
    try {
      final channelName = _generateChannelName(doctor);

      // Navigate to Audio Call Screen
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AudioCallScreen(
            channelName: channelName,
            doctorName: doctor.name ?? "",
            engine: _engine!,
          ),
        ),
      );
    } catch (e) {
      Helpers.showSnackBar(context, "Failed to start audio call: $e");
    }
  }*/

  // Start Video Call
  /*Future<void> _startVideoCall(DoctorData doctor) async {
    try {
      final channelName = _generateChannelName(doctor);

      // Navigate to Video Call Screen
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => VideoCallScreen(
            doctorId: doctor.sId.toString(),
            channelName: channelName,
            doctorName: doctor.name ?? "",
            engine: _engine!,
          ),
        ),
      );
    } catch (e) {
      Helpers.showSnackBar(context, "Failed to start video call: $e");
    }
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CustomAppBar(
        title: LabelString.labelCallDoctor,
        isNotification: true,
      ),
      body: BlocConsumer<PatientBloc, PatientState>(
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
            doctorResponse = state.data;
            if (doctorResponse != null) {
              doctors = doctorResponse?.doctorData;
              doctorsTypes = doctors!.map((doc) => doc.type.toString()).toSet().toList();
              //filterDoctorsByType(selectedSpecialtyNotifier.value);
              filteredDoctors = doctors?.where((doctor) => doctor.type == selectedSpecialtyNotifier.value).toList();
            }
          }
        },
        builder: (context, state) {
          return LoadingWrapper(
            showSpinner: showSpinner,
            child: Padding(
              padding: EdgeInsets.all(16.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    LabelString.labelLookingDoctor,
                    style: GoogleFonts.dmSans(color: AppColors.redColor, fontSize: 22.sp, fontWeight: GoogleFontWeight.semiBold),
                  ),
                  4.verticalSpace,
                  CustomTextField(
                    label: "",
                    controller: searchController,
                    suffixIcon: Padding(
                      padding: EdgeInsets.all(12.sp),
                      child: Assets.icIcons.search.svg(colorFilter: ColorFilter.mode(AppColors.redColor, BlendMode.srcIn)),
                    ),
                    hintText: LabelString.labelSearchHint,
                  ),
                  4.verticalSpace,

                  SizedBox(
                    height: 32.sp,
                    child: ValueListenableBuilder<String>(
                      valueListenable: selectedSpecialtyNotifier,
                      builder: (context, selectedSpecialty, child) {
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: doctorsTypes?.length ?? 0,
                          itemBuilder: (context, index) {
                            bool isSelected = doctorsTypes?[index] == selectedSpecialty;
                            return GestureDetector(
                              onTap: () {
                                selectedSpecialtyNotifier.value = doctorsTypes![index];
                                final selectedType = doctorsTypes![index];
                                selectedSpecialtyNotifier.value = selectedType;
                              },
                              child: Container(
                                margin: EdgeInsets.only(right: 12.sp),
                                padding: EdgeInsets.symmetric(horizontal: 14.sp),
                                decoration: BoxDecoration(
                                  color: isSelected ? AppColors.blueColor.withValues(alpha: 0.1) : AppColors.whiteColor,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: isSelected ? AppColors.transparent : AppColors.gray.withValues(alpha: 0.2)),
                                ),
                                child: Center(
                                  child: Text(
                                    doctorsTypes?[index] ?? "",
                                    style: GoogleFonts.dmSans(
                                      color: isSelected ? AppColors.blueColor : AppColors.blackColor,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                  12.verticalSpace,
                  Expanded(
                    child: ListView.builder(
                      itemCount: filteredDoctors?.length ?? 0,
                      itemBuilder: (context, index) {
                        return DoctorCard(
                          doctor: filteredDoctors?[index],
                          onAudioCall: () async {
                            Helpers.startCall(filteredDoctors![index].phone);
                            // _startAudioCall(filteredDoctors![index]);
                            /*launchUrlString("tel://${filteredDoctors![index].phone}",
                                mode: LaunchMode.platformDefault);*/
                          },
                          onVideoCall: () {
                            //_startVideoCall(filteredDoctors![index]);
                          },
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
    );
  }
}

class DoctorCard extends StatelessWidget {
  final DoctorData? doctor;
  final VoidCallback? onAudioCall;
  final VoidCallback? onVideoCall;

  DoctorCard({
    Key? key,
    this.doctor,
    this.onAudioCall,
    this.onVideoCall,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.sp),
      padding: EdgeInsets.all(13.sp),
      decoration: BoxDecoration(
        color: AppColors.greyBg,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10, offset: Offset(0, 2))],
      ),
      child: Row(
        children: [
          Container(
              width: 50.sp,
              height: 50.sp,
              decoration: BoxDecoration(shape: BoxShape.circle),
              child: Image.asset("assets/images/profile.png")
          ),
          13.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(doctor?.name ?? "",
                    style: GoogleFonts.dmSans(fontSize: 14.sp, fontWeight: FontWeight.bold, color: AppColors.blackColor)),
                2.verticalSpace,
                Text(doctor?.type ?? "", style: GoogleFonts.dmSans(fontSize: 12.sp, color: AppColors.gray)),
              ],
            ),
          ),
          Row(
            children: [
              GestureDetector(
                onTap: onAudioCall,
                child: Container(
                  decoration: BoxDecoration(color: AppColors.whiteColor, shape: BoxShape.circle),
                  padding: EdgeInsets.all(6.sp),
                  child: Assets.icIcons.call.svg(colorFilter: ColorFilter.mode(AppColors.redColor, BlendMode.srcIn)),
                ),
              ),
              10.horizontalSpace,
              GestureDetector(
                onTap: onVideoCall,
                child: Container(
                  decoration: BoxDecoration(color: AppColors.whiteColor, shape: BoxShape.circle),
                  padding: EdgeInsets.all(6.sp),
                  child: Assets.icIcons.video.svg(colorFilter: ColorFilter.mode(AppColors.redColor, BlendMode.srcIn)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Audio Call Screen
class AudioCallScreen extends StatefulWidget {
  final String channelName;
  final String doctorName;
  final RtcEngine engine;

  const AudioCallScreen({
    Key? key,
    required this.channelName,
    required this.doctorName,
    required this.engine,
  }) : super(key: key);

  @override
  State<AudioCallScreen> createState() => _AudioCallScreenState();
}

class _AudioCallScreenState extends State<AudioCallScreen> {
  bool _isMuted = false;
  bool _isJoined = false;
  bool _remoteUserJoined = false;

  @override
  void initState() {
    super.initState();
    _joinChannel();
  }

  @override
  void dispose() {
    _leaveChannel();
    super.dispose();
  }

  Future<void> _joinChannel() async {
    await widget.engine.enableAudio();
    await widget.engine.disableVideo();

    widget.engine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          setState(() {
            _isJoined = true;
          });
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          setState(() {
            _remoteUserJoined = true;
          });
        },
        onUserOffline: (RtcConnection connection, int remoteUid, UserOfflineReasonType reason) {
          setState(() {
            _remoteUserJoined = false;
          });
        },
      ),
    );

    await widget.engine.joinChannel(
      token: "007eJxTYJjIdKompko7/FRmZFYvh6Tvw37Zvx+KGZ7PVUw1nJgb1K/AkJySamlpnmSeZpRobJJkbJRkZmFuZmZgkmxkYW5kmmL5VGB/RkMgI8P2FhFWRgYIBPFZGEpSi0sYGADM4R26", // Use null for testing, implement token server for production
      channelId: widget.channelName,
      uid: 0,
      options: const ChannelMediaOptions(),
    );
  }

  Future<void> _leaveChannel() async {
    await widget.engine.leaveChannel();
  }

  void _toggleMute() {
    setState(() {
      _isMuted = !_isMuted;
    });
    widget.engine.muteLocalAudioStream(_isMuted);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blackColor,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 120.sp,
                      height: 120.sp,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.gray.withValues(alpha: 0.3),
                      ),
                      child: Icon(
                        Icons.person,
                        size: 60.sp,
                        color: AppColors.whiteColor,
                      ),
                    ),
                    20.verticalSpace,
                    Text(
                      widget.doctorName,
                      style: GoogleFonts.dmSans(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.whiteColor,
                      ),
                    ),
                    8.verticalSpace,
                    Text(
                      _remoteUserJoined ? "Connected" : _isJoined ? "Connecting..." : "Calling...",
                      style: GoogleFonts.dmSans(
                        fontSize: 16.sp,
                        color: AppColors.gray,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.sp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Mute button
                  GestureDetector(
                    onTap: _toggleMute,
                    child: Container(
                      width: 60.sp,
                      height: 60.sp,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _isMuted ? AppColors.redColor : AppColors.gray.withValues(alpha: 0.3),
                      ),
                      child: Icon(
                        _isMuted ? Icons.mic_off : Icons.mic,
                        color: AppColors.whiteColor,
                        size: 28.sp,
                      ),
                    ),
                  ),
                  // End call button
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 70.sp,
                      height: 70.sp,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.redColor,
                      ),
                      child: Icon(
                        Icons.call_end,
                        color: AppColors.whiteColor,
                        size: 32.sp,
                      ),
                    ),
                  ),
                  // Speaker button
                  GestureDetector(
                    onTap: () {
                      widget.engine.setEnableSpeakerphone(true);
                    },
                    child: Container(
                      width: 60.sp,
                      height: 60.sp,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.gray.withValues(alpha: 0.3),
                      ),
                      child: Icon(
                        Icons.volume_up,
                        color: AppColors.whiteColor,
                        size: 28.sp,
                      ),
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

/*
// Video Call Screen
class VideoCallScreen extends StatefulWidget {
  final String channelName;
  final String doctorName;
  final String doctorId;
  final RtcEngine engine;

  const VideoCallScreen({
    Key? key,
    required this.channelName,
    required this.doctorName,
    required this.doctorId,
    required this.engine,
  }) : super(key: key);

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  bool _isMuted = false;
  bool _isVideoEnabled = true;
  bool _isJoined = false;
  int? _remoteUid;

  @override
  void initState() {
    super.initState();
    _joinChannel();
  }

  @override
  void dispose() {
    _leaveChannel();
    super.dispose();
  }

  Future<void> _joinChannel() async {
    await widget.engine.enableVideo();
    await widget.engine.enableAudio();
    await widget.engine.startPreview();

    widget.engine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          setState(() {
            _isJoined = true;
          });
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          setState(() {
            _remoteUid = remoteUid;
          });
        },
        onUserOffline: (RtcConnection connection, int remoteUid, UserOfflineReasonType reason) {
          setState(() {
            _remoteUid = null;
          });
        },
      ),
    );

    await widget.engine.joinChannel(
      token: "007eJxTYJjIdKompko7/FRmZFYvh6Tvw37Zvx+KGZ7PVUw1nJgb1K/AkJySamlpnmSeZpRobJJkbJRkZmFuZmZgkmxkYW5kmmL5VGB/RkMgI8P2FhFWRgYIBPFZGEpSi0sYGADM4R26", // Use null for testing, implement token server for production
      channelId: widget.channelName,
      uid: 0,
      options: const ChannelMediaOptions(),
    );
  }

  Future<void> _leaveChannel() async {
    await widget.engine.leaveChannel();
  }

  void _toggleMute() {
    setState(() {
      _isMuted = !_isMuted;
    });
    widget.engine.muteLocalAudioStream(_isMuted);
  }

  void _toggleVideo() {
    setState(() {
      _isVideoEnabled = !_isVideoEnabled;
    });
    widget.engine.muteLocalVideoStream(!_isVideoEnabled);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blackColor,
      body: SafeArea(
        child: Stack(
          children: [
            // Remote video view
            _remoteUid != null
                ? AgoraVideoView(
              controller: VideoViewController.remote(
                rtcEngine: widget.engine,
                canvas: VideoCanvas(uid: _remoteUid),
                connection: RtcConnection(channelId: widget.channelName),
              ),
            )
                : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 120.sp,
                    height: 120.sp,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.gray.withValues(alpha: 0.3),
                    ),
                    child: Icon(
                      Icons.person,
                      size: 60.sp,
                      color: AppColors.whiteColor,
                    ),
                  ),
                  20.verticalSpace,
                  Text(
                    widget.doctorName,
                    style: GoogleFonts.dmSans(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.whiteColor,
                    ),
                  ),
                  8.verticalSpace,
                  Text(
                    _isJoined ? "Connecting..." : "Calling...",
                    style: GoogleFonts.dmSans(
                      fontSize: 16.sp,
                      color: AppColors.gray,
                    ),
                  ),
                ],
              ),
            ),

            // Local video view (small preview)
            Positioned(
              top: 40.sp,
              right: 20.sp,
              child: Container(
                width: 120.sp,
                height: 160.sp,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.whiteColor, width: 2),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: _isVideoEnabled
                      ? AgoraVideoView(
                    controller: VideoViewController(
                      rtcEngine: widget.engine,
                      canvas: const VideoCanvas(uid: 0),
                    ),
                  )
                      : Container(
                    color: AppColors.blackColor,
                    child: Center(
                      child: Icon(
                        Icons.videocam_off,
                        color: AppColors.whiteColor,
                        size: 40.sp,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Control buttons at bottom
            Positioned(
              bottom: 40.sp,
              left: 0,
              right: 0,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.sp),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Mute button
                    GestureDetector(
                      onTap: _toggleMute,
                      child: Container(
                        width: 60.sp,
                        height: 60.sp,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _isMuted ? AppColors.redColor : AppColors.gray.withValues(alpha: 0.3),
                        ),
                        child: Icon(
                          _isMuted ? Icons.mic_off : Icons.mic,
                          color: AppColors.whiteColor,
                          size: 28.sp,
                        ),
                      ),
                    ),
                    // End call button
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: 70.sp,
                        height: 70.sp,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.redColor,
                        ),
                        child: Icon(
                          Icons.call_end,
                          color: AppColors.whiteColor,
                          size: 32.sp,
                        ),
                      ),
                    ),
                    // Video toggle button
                    GestureDetector(
                      onTap: _toggleVideo,
                      child: Container(
                        width: 60.sp,
                        height: 60.sp,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: !_isVideoEnabled ? AppColors.redColor : AppColors.gray.withValues(alpha: 0.3),
                        ),
                        child: Icon(
                          _isVideoEnabled ? Icons.videocam : Icons.videocam_off,
                          color: AppColors.whiteColor,
                          size: 28.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}*/
