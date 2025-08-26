import 'dart:convert';
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../constants/constants.dart';
import '../constants/strings.dart';

class HttpActions {
  String endPoint = Constants.of().endpoint;

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

  Future<dynamic> getMethod(String url) async {
    if ((await checkConnection()) != ConnectivityResult.none) {
      http.Response response = await http.get(Uri.parse(endPoint + url));
      return jsonDecode(utf8.decode(response.bodyBytes));
    } else {
      Future.error(ErrorString.noInternet);
    }
  }

  Future<dynamic> getMethodWithQueryParam(
      String url, {
        Map<String, String>? headers,
        Map<String, dynamic>? queryParams,
        bool shouldCancelRequest = false,
      }) async {
    if ((await checkConnection()) != ConnectivityResult.none) {
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

  Map<String, String> getSessionData(Map<String, String> headers) {
    headers["content-type"] = "application/json";
    headers["Accept"] = "application/json";
    return headers;
  }

  Future<List<ConnectivityResult>> checkConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    return connectivityResult;
  }
}
