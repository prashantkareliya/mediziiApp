import 'package:hive/hive.dart';

import 'hive_keys.dart';

class HiveService {
  final Box _box = Hive.box(HiveKeys.authBox);

  // Save token
  Future<void> saveToken(String token) async {
    await _box.put(HiveKeys.token, token);
  }

  // Get token
  String? getToken() {
    return _box.get(HiveKeys.token);
  }

  // Delete token
  Future<void> deleteToken() async {
    await _box.delete(HiveKeys.token);
  }
}
