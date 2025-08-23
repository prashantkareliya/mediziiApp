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
      endpoint: 'https://shuddhdesiradio.globaltechnosys.com/api/v1/', //  staging server
      //endpoint: 'https://shuddhdesiradio.globaltechnosys.com/api/v1/', //  live server
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
  static const String contactForm= "contactform/submit";
  static const String advtWithUs= "boomtechform/submit";
  static const String songRequest= "songrequestform/submit";

  //GET API endpoint
  static const String getSponsors = "collections/sponsors";
  static const String getTeam = "collections/teams";
  static const String getCity = "collections/cities";
  static const String getCitySchedule = "collections/cities/schedules";

  //PUT API endpoint
  static const String profileUpdate = "user/profile/update";
}
