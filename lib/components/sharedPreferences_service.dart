import 'package:shared_preferences/shared_preferences.dart';

class PreferenceService {
  static final PreferenceService _instance = PreferenceService._internal();
  late SharedPreferences _prefs;

  factory PreferenceService() {
    return _instance;
  }

  PreferenceService._internal();

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  SharedPreferences get prefs => _prefs;
}
