import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:medizii/components/sharedPreferences_service.dart';

import '../constants/constants.dart';
import '../constants/strings.dart';

class HttpActions {
  String endPoint = Constants.of().endpoint;
  final prefs = PreferenceService().prefs;
  http.Client _client = http.Client();

  Future<dynamic> postMethod(String url, {dynamic data, Map<String, String>? headers}) async {
    if ((await checkConnection()) != ConnectivityResult.none) {
      debugPrint("data $data");
      debugPrint("URL -- ${endPoint + url}");
      debugPrint(Uri.parse(endPoint + url).toString());
      http.Response response = await http.post(
        Uri.parse(endPoint + url),
        body: jsonEncode(data),
        headers: {'Content-Type': 'application/json', 'Accept': 'application/json'},
      );
      return jsonDecode(utf8.decode(response.bodyBytes));
    } else {
      Future.error(ErrorString.noInternet);
    }
  }

  Future<dynamic> getMethod(String url, {Map<String, String>? headers}) async {
    if ((await checkConnection()) != ConnectivityResult.none) {
      headers = getSessionData(headers ?? {}, prefs.getString(PreferenceString.prefsToken));

      http.Response response = await http.get(Uri.parse(endPoint + url), headers: headers);

      return jsonDecode(utf8.decode(response.bodyBytes));
    } else {
      Future.error(ErrorString.noInternet);
    }
  }

  Future<dynamic> getMethodWithBody(String url,
      {Map<String, String>? headers, Map<String, dynamic>? body}) async {
    if ((await checkConnection()) != ConnectivityResult.none) {
      headers = getSessionData(headers ?? {}, prefs.getString(PreferenceString.prefsToken));
      headers['Content-Type'] = 'application/json';

      // Create the request manually
      var uri = Uri.parse(endPoint + url);
      var request = http.Request('GET', uri);
      request.headers.addAll(headers);
      request.body = jsonEncode(body);

      // Send the request
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      return jsonDecode(utf8.decode(response.bodyBytes));
    } else {
      return Future.error(ErrorString.noInternet);
    }
  }

  Future<dynamic> getMethodWithQueryParam(
      String url, {
        Map<String, String>? headers,
        Map<String, dynamic>? queryParams,
        bool shouldCancelRequest = false,
      }) async {
    if ((await checkConnection()) != ConnectivityResult.none) {
      headers = getSessionData(headers ?? {}, prefs.getString(PreferenceString.prefsToken));
      String finalUrl = endPoint + url;
      if (queryParams != null) {
        queryParams.forEach((key, value) {
          if (key == queryParams.keys.first) {
            finalUrl = "$finalUrl?$key=$value";
          } else {
            finalUrl = "$finalUrl&$key=$value";
          }
        });
      }
      log("URl -- $finalUrl");
      log(DateTime.now().microsecondsSinceEpoch.toString());
      if (shouldCancelRequest) {
        _client.close();
        _client = http.Client();
      }
      try {
        http.Response response = await _client.get(Uri.parse(finalUrl), headers: headers);
        print("After Response URl -- $finalUrl");
        log(DateTime.now().microsecondsSinceEpoch.toString());
        return jsonDecode(utf8.decode(response.bodyBytes));
      } catch (e) {
        return "Please check your internet connection";
      }
    } else {
      Future.error(ErrorString.noInternet);
    }
  }

  Future<dynamic> deleteMethodWithQueryParam(
      String url, {
        Map<String, String>? headers,
        Map<String, dynamic>? queryParams,
        bool shouldCancelRequest = false,
      }) async {
    if ((await checkConnection()) != ConnectivityResult.none) {
      headers = getSessionData(headers ?? {});

      String finalUrl = endPoint + url;
      if (queryParams != null) {
        queryParams.forEach((key, value) {
          if (key == queryParams.keys.first) {
            finalUrl = "$finalUrl?$key=$value";
          } else {
            finalUrl = "$finalUrl&$key=$value";
          }
        });
      }
      log("URl -- $finalUrl");
      log(DateTime.now().microsecondsSinceEpoch.toString());
      if (shouldCancelRequest) {
        _client.close();
        _client = http.Client();
      }
      try {
        http.Response response = await _client.delete(Uri.parse(finalUrl), headers: headers);
        log("After Response URl -- $finalUrl");
        log(DateTime.now().microsecondsSinceEpoch.toString());
        return jsonDecode(utf8.decode(response.bodyBytes));
      } catch (e) {
        return "Please check your internet connection";
      }
    } else {
      Future.error(ErrorString.noInternet);
    }
  }

  Future<dynamic> postMultiPartMethod(String url,
      {required Map<String, dynamic> data, Map<String, String>? headers}) async {
    if ((await checkConnection()) != ConnectivityResult.none) {
      headers = getSessionData(headers ?? {}, prefs.getString(PreferenceString.prefsToken));

      var request = http.MultipartRequest('POST', Uri.parse(endPoint + url));

      for (var key in data.keys) {
        var value = data[key];

        if (value is http.MultipartFile) {
          request.files.add(value);
        } else if (value is List<http.MultipartFile>) {
          request.files.addAll(value);
        } else {
          request.fields[key] = value.toString();
        }
      }

      request.headers.addAll(headers);

      try {
        var streamedResponse = await request.send().timeout(
          const Duration(seconds: 1400),
          onTimeout: () => throw TimeoutException("Request timed out"),
        );

        final apiResponse = await http.Response.fromStream(streamedResponse);
        String decoded = utf8.decode(apiResponse.bodyBytes);
        return jsonDecode(decoded);
      } catch (e) {
        return Future.error(e.toString());
      }
    } else {
      return Future.error("No Internet Connection");
    }
  }



  Map<String, String> getSessionData(Map<String, String> headers, [String? token]) {
    headers["content-type"] = "application/json";
    headers["Accept"] = "application/json";
    headers["Authorization"] = "Bearer $token";
    return headers;
  }

  Future<List<ConnectivityResult>> checkConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    return connectivityResult;
  }
}
