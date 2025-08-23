import 'package:flutter/material.dart';
import 'package:medizii/constants/strings.dart';

class AuthProvider extends ChangeNotifier {
  String _selectedRole = LabelString.labelDoctor;

  String get selectedRole => _selectedRole;

  void setSelectedRole(String role) {
    _selectedRole = role;
    notifyListeners();
  }
}
