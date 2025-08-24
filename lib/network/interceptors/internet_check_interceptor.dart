import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:medizii/main.dart';
import 'package:medizii/screens/no_internet_screen.dart';

class InternetCheckInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final connectivity = await Connectivity().checkConnectivity();

    if (connectivity == ConnectivityResult.none) {
      navigationService.pushReplacement(const NoInternetScreen());
      return handler.reject(DioException(requestOptions: options, type: DioExceptionType.unknown, error: "No internet connection"));
    }

    super.onRequest(options, handler);
  }
}
