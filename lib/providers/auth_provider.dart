import 'package:medizii/constants/api_constants.dart';
import 'package:medizii/constants/strings.dart';
import 'package:medizii/local/hive_service.dart';
import 'package:medizii/main.dart';
import 'package:medizii/network/enhanced_api_service.dart';
import 'package:medizii/providers/base_provider.dart';
import 'package:medizii/screens/authentication/auth_screen.dart';

class AuthProvider extends BaseProvider {
  final EnhancedApiService _apiService = EnhancedApiService();
  final HiveService _hiveService = HiveService();

  String? token;

  String _selectedRole = LabelString.labelDoctor;

  String get selectedRole => _selectedRole;

  void setSelectedRole(String role) {
    _selectedRole = role;
    notifyListeners();
  }

  Future<bool> login(String email, String password) async {
    return await executeAsyncBool(() async {
      final data = {"email": email, "password": password};

      final result = await _apiService.post(
        ApiConstants.loginEndpoint,
        data: data,
      );

      return result.fold((response) {
        if (response['token'] != null) {
          token = response['token'];
          _hiveService.saveToken(token!);
          return true;
        } else {
          throw Exception(
            response['message'] ?? "Invalid response from server",
          );
        }
      }, (error) => throw Exception(error));
    });
  }

  Future<void> logout() async {
    await executeAsyncVoid(() async {
      await _hiveService.deleteToken();
      token = null;
      notifyListeners();
      if (token == null) {
        navigationService.pushAndRemoveUntil(AuthScreen(false));
      }
    });
  }

  /// Test method to demonstrate network error handling
  Future<bool> testNetworkError() async {
    return await executeAsyncBool(() async {
      // This will fail and trigger the NoInternetScreen
      final result = await _apiService.get(
        'https://unreachable-server.com/api/test',
      );

      return result.fold((response) => true, (error) => throw Exception(error));
    });
  }

  void loadToken() {
    token = _hiveService.getToken();
    notifyListeners();
  }
}
