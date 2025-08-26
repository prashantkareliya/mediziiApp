import 'package:flutter/material.dart';

@immutable
class Constants {
  const Constants({required this.endpoint});

  factory Constants.of() {
    if (_instance != null) return _instance!;
    _instance = Constants._prd();
    return _instance!;
  }

  factory Constants._prd() {
    return const Constants(
      ///Base URl
      endpoint: 'https://medizii.onrender.com/', //  staging server
    );
  }

  static Constants? _instance;
  final String endpoint;
}

class ResponseStatus {
  static const bool failed = true;
  static const bool success = true;
}

class ApiEndPoint {
  //POST API endpoint
  static const String createUser = "user/login";

  //GET API endpoint

  //PUT API endpoint
}
