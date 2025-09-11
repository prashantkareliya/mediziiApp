/*
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:medizii/constants/strings.dart';

class AgoraService {
  static const String agoraAppId = AgoraString.agoraAppId;
  static RtcEngine? _engine;

  static Future<RtcEngine?> initializeAgora() async {
    // Request permissions
    await [Permission.microphone, Permission.camera].request();

    // Create Agora engine if not already created
    if (_engine == null) {
      _engine = createAgoraRtcEngine();
      await _engine!.initialize(RtcEngineContext(
        appId: agoraAppId,
        channelProfile: ChannelProfileType.channelProfileCommunication,
      ));

      // Enable video and audio
      await _engine!.enableVideo();
      await _engine!.enableAudio();
    }

    return _engine;
  }

  static Future<void> disposeEngine() async {
    await _engine?.leaveChannel();
    await _engine?.release();
    _engine = null;
  }

  static RtcEngine? get engine => _engine;

  // Generate unique channel name
  static String generateChannelName(String doctorId) {
    return "call_${doctorId}_${DateTime.now().millisecondsSinceEpoch}";
  }

  // Check if permissions are granted
  static Future<bool> checkPermissions() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.microphone,
      Permission.camera,
    ].request();

    return statuses[Permission.microphone]!.isGranted &&
        statuses[Permission.camera]!.isGranted;
  }

  // Request permissions with custom handling
  static Future<bool> requestPermissions() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.microphone,
      Permission.camera,
    ].request();

    bool microphoneGranted = statuses[Permission.microphone]!.isGranted;
    bool cameraGranted = statuses[Permission.camera]!.isGranted;

    if (!microphoneGranted || !cameraGranted) {
      // Handle permission denied
      return false;
    }

    return true;
  }

  // Generate Agora token (for production, implement server-side token generation)
  static Future<String?> generateToken(String channelName, int uid) async {
    // For testing purposes, you can use null token
    // For production, implement server-side token generation
    // Return await YourTokenServer.generateToken(channelName, uid);
    return null;
  }
}*/
