import 'package:medizii/constants/api_constants.dart';
import 'package:medizii/network/enhanced_api_service.dart';
import 'package:medizii/providers/base_provider.dart';

class ExampleProvider extends BaseProvider {
  final EnhancedApiService _apiService = EnhancedApiService();

  /// Example login method using enhanced API service
  Future<bool> login(String email, String password) async {
    return await executeAsyncBool(() async {
      final data = {"email": email, "password": password};

      final result = await _apiService.post(
        ApiConstants.loginEndpoint,
        data: data,
      );

      return result.fold(
        (response) {
          // Handle success
          if (response['token'] != null) {
            // Save token logic here
            return true;
          } else {
            throw Exception(response['message'] ?? "Invalid response");
          }
        },
        (error) {
          // Handle error
          throw Exception(error);
        },
      );
    });
  }

  /// Example method to fetch user data
  Future<Map<String, dynamic>?> fetchUserData() async {
    return await executeAsync(() async {
      final result = await _apiService.get('/user/profile');

      return result.fold(
        (data) => data as Map<String, dynamic>,
        (error) => throw Exception(error),
      );
    });
  }

  /// Example method to update user profile
  Future<bool> updateProfile(Map<String, dynamic> profileData) async {
    return await executeAsyncBool(() async {
      final result = await _apiService.put('/user/profile', data: profileData);

      return result.fold((response) => true, (error) => throw Exception(error));
    });
  }
}
