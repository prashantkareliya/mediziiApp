import 'package:flutter/material.dart';
import 'package:medizii/constants/api_constants.dart';
import 'package:medizii/constants/strings.dart';
import 'package:medizii/local/hive_service.dart';
import 'package:medizii/main.dart';
import 'package:medizii/network/api_service.dart';
import 'package:medizii/network/app_exception.dart';
import 'package:medizii/screens/authentication/auth_screen.dart';

class AuthProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  final HiveService _hiveService = HiveService();

  bool isLoading = false;
  String? errorMessage;
  String? token;

  String _selectedRole = LabelString.labelDoctor;

  String get selectedRole => _selectedRole;

  void setSelectedRole(String role) {
    _selectedRole = role;
    notifyListeners();
  }

  Future<bool> login(String email, String password) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    final data = {
      "email": email,
      "password": password,
    };

    try {
      final response = await _apiService.post(ApiConstants.loginEndpoint, data: data);
      token = response['token'];
      if (token != null) {
        await _hiveService.saveToken(token!);
        return true;
      } else {
        errorMessage = "Invalid response from server";
        return false;
      }
      return true;
    } on AppException catch (e) {
      errorMessage = e.message;
      return false;
    } catch (_) {
      errorMessage = "Unexpected error occurred";
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    await _hiveService.deleteToken();
    token = null;
    notifyListeners();
    if(token == null){
      navigationService.pushAndRemoveUntil(AuthScreen(false));
    }
  }

  void loadToken() {
    token = _hiveService.getToken();
    notifyListeners();
  }
}
