/// Represents the result of an API call
class ApiResult<T> {
  final T? data;
  final String? error;
  final bool isSuccess;

  ApiResult._({this.data, this.error, required this.isSuccess});

  /// Create a success result
  factory ApiResult.success(T data) {
    return ApiResult._(data: data, isSuccess: true);
  }

  /// Create an error result
  factory ApiResult.error(String error) {
    return ApiResult._(error: error, isSuccess: false);
  }

  /// Check if the result is successful
  bool get isError => !isSuccess;

  /// Get data or throw if error
  T get requireData {
    if (isSuccess && data != null) {
      return data!;
    }
    throw Exception(error ?? 'No data available');
  }

  /// Transform the data if successful
  ApiResult<R> map<R>(R Function(T) transform) {
    if (isSuccess && data != null) {
      return ApiResult.success(transform(data!));
    }
    return ApiResult.error(error ?? 'Unknown error');
  }

  /// Execute different functions based on success/error
  R fold<R>(R Function(T) onSuccess, R Function(String) onError) {
    if (isSuccess && data != null) {
      return onSuccess(data!);
    }
    return onError(error ?? 'Unknown error');
  }
}
