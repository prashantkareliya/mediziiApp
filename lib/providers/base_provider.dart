import 'package:flutter/material.dart';
import 'package:medizii/network/app_exception.dart';

abstract class BaseProvider extends ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  /// Execute an async operation with automatic loading and error handling
  Future<T?> executeAsync<T>(Future<T> Function() operation) async {
    _setLoading(true);
    _clearError();

    try {
      final result = await operation();
      _setLoading(false);
      return result;
    } on AppException catch (e) {
      _setError(e.message);
      return null;
    } catch (e) {
      _setError("Unexpected error occurred: ${e.toString()}");
      return null;
    }
  }

  /// Execute an async operation that returns a boolean result
  Future<bool> executeAsyncBool(Future<bool> Function() operation) async {
    final result = await executeAsync(operation);
    return result ?? false;
  }

  /// Execute an async operation that doesn't return a value
  Future<void> executeAsyncVoid(Future<void> Function() operation) async {
    await executeAsync(() async {
      await operation();
      return true; // Return dummy value since we don't need it
    });
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String message) {
    _errorMessage = message;
    _isLoading = false;
    notifyListeners();
  }

  void _clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  /// Clear error message manually
  void clearError() {
    _clearError();
  }

  /// Set loading state manually
  void setLoading(bool loading) {
    _setLoading(loading);
  }
}
