# API Call Structure Documentation

## Overview
This project uses a clean architecture pattern with automatic error handling to eliminate the need for try-catch blocks in every provider.

## Architecture Components

### 1. BaseProvider
The `BaseProvider` class provides automatic loading and error handling for all providers.

**Features:**
- Automatic loading state management
- Automatic error handling
- No need for try-catch blocks
- Consistent error messages

**Usage:**
```dart
class MyProvider extends BaseProvider {
  Future<bool> someOperation() async {
    return await executeAsyncBool(() async {
      // Your async operation here
      // Any exception will be automatically caught and handled
      return true;
    });
  }
}
```

### 2. EnhancedApiService
Returns `ApiResult<T>` objects that encapsulate success/error states.

**Features:**
- Automatic error handling
- Type-safe responses
- Functional programming approach with `fold()`
- No null returns

**Usage:**
```dart
final result = await _apiService.post('/endpoint', data: data);

return result.fold(
  (success) => handleSuccess(success),
  (error) => throw Exception(error),
);
```

### 3. ApiResult
A functional result type that represents success or error states.

**Methods:**
- `fold()` - Handle both success and error cases
- `map()` - Transform successful data
- `isSuccess` - Check if operation succeeded
- `isError` - Check if operation failed

## Provider Examples

### Simple Provider
```dart
class SimpleProvider extends BaseProvider {
  final EnhancedApiService _apiService = EnhancedApiService();

  Future<bool> login(String email, String password) async {
    return await executeAsyncBool(() async {
      final data = {"email": email, "password": password};
      
      final result = await _apiService.post('/login', data: data);
      
      return result.fold(
        (response) {
          // Handle success
          if (response['token'] != null) {
            // Save token
            return true;
          } else {
            throw Exception(response['message'] ?? "Invalid response");
          }
        },
        (error) => throw Exception(error),
      );
    });
  }
}
```

### Complex Provider
```dart
class ComplexProvider extends BaseProvider {
  final EnhancedApiService _apiService = EnhancedApiService();

  Future<User?> fetchUser() async {
    return await executeAsync(() async {
      final result = await _apiService.get('/user/profile');
      
      return result.fold(
        (data) => User.fromJson(data),
        (error) => throw Exception(error),
      );
    });
  }

  Future<bool> updateUser(User user) async {
    return await executeAsyncBool(() async {
      final result = await _apiService.put('/user/profile', data: user.toJson());
      
      return result.fold(
        (response) => true,
        (error) => throw Exception(error),
      );
    });
  }
}
```

## UI Usage

### In Widgets
```dart
class LoginWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, auth, child) {
        return Column(
          children: [
            if (auth.isLoading)
              CircularProgressIndicator(),
            
            if (auth.errorMessage != null)
              Text(auth.errorMessage!, style: TextStyle(color: Colors.red)),
            
            ElevatedButton(
              onPressed: auth.isLoading ? null : () async {
                final success = await auth.login(email, password);
                if (success) {
                  // Navigate to dashboard
                }
              },
              child: Text('Login'),
            ),
          ],
        );
      },
    );
  }
}
```

## Benefits

1. **No Try-Catch Blocks**: Automatic error handling in BaseProvider
2. **Consistent Error Messages**: Standardized error handling across the app
3. **Type Safety**: ApiResult provides compile-time safety
4. **Functional Programming**: Clean separation of success/error logic
5. **Maintainable**: Easy to add new providers without boilerplate
6. **Testable**: Clear separation of concerns

## Migration Guide

### From Old Structure
**Before:**
```dart
class OldProvider extends ChangeNotifier {
  bool isLoading = false;
  String? errorMessage;

  Future<bool> login() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final response = await _apiService.post('/login', data: data);
      // Handle response
      return true;
    } catch (e) {
      errorMessage = e.toString();
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
```

**After:**
```dart
class NewProvider extends BaseProvider {
  Future<bool> login() async {
    return await executeAsyncBool(() async {
      final result = await _apiService.post('/login', data: data);
      
      return result.fold(
        (response) => true,
        (error) => throw Exception(error),
      );
    });
  }
}
```

## Best Practices

1. **Always extend BaseProvider** for new providers
2. **Use executeAsyncBool()** for operations that return boolean
3. **Use executeAsync()** for operations that return data
4. **Use executeAsyncVoid()** for operations that don't return anything
5. **Use result.fold()** to handle API responses
6. **Throw exceptions** instead of returning false for errors
7. **Keep providers focused** on single responsibility
