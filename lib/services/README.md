# Internet Connectivity System

## Overview
This system automatically detects when there's no internet connection and shows a dedicated "No Internet" screen to the user.

## Components

### 1. ConnectivityService
- **Location**: `lib/services/connectivity_service.dart`
- **Purpose**: Monitors internet connectivity status
- **Features**:
  - Real-time connectivity monitoring
  - Stream-based updates
  - Singleton pattern for app-wide access

### 2. NoInternetScreen
- **Location**: `lib/screens/no_internet_screen.dart`
- **Purpose**: UI shown when no internet is available
- **Features**:
  - Retry button with loading state
  - Automatic navigation when internet returns
  - User-friendly error messages

### 3. ConnectivityWrapper
- **Location**: `lib/components/connectivity_wrapper.dart`
- **Purpose**: Wraps the app to monitor connectivity
- **Features**:
  - Automatically shows NoInternetScreen when offline
  - Returns to normal app when online
  - No manual intervention needed

### 4. InternetCheckInterceptor
- **Location**: `lib/network/interceptors/internet_check_interceptor.dart`
- **Purpose**: Prevents API calls when offline
- **Features**:
  - Checks connectivity before each API request
  - Rejects requests when offline
  - Prevents unnecessary network calls

### 5. NetworkErrorInterceptor
- **Location**: `lib/network/interceptors/network_error_interceptor.dart`
- **Purpose**: Shows NoInternetScreen when API calls fail due to network issues
- **Features**:
  - Catches network-related errors from API calls
  - Automatically shows NoInternetScreen on network failures
  - Prevents multiple screens from showing simultaneously

## How It Works

### 1. Initialization
```dart
// In main.dart
await ConnectivityService().initialize();
```

### 2. App Wrapping
```dart
// In main.dart
ConnectivityWrapper(
  child: YourApp(),
)
```

### 3. Automatic Detection
- The system continuously monitors connectivity
- When internet is lost, `NoInternetScreen` is shown automatically
- When internet returns, the app resumes normally

### 4. API Protection
- All API calls are intercepted
- Requests are rejected if no internet
- Prevents app crashes from network errors

### 5. Network Error Handling
- API calls that fail due to network issues show NoInternetScreen
- Automatic detection of network-related errors
- Seamless user experience during network failures

## Usage Examples

### Manual Connectivity Check
```dart
final connectivityService = ConnectivityService();
final isConnected = await connectivityService.checkConnectivity();

if (isConnected) {
  // Proceed with network operation
} else {
  // Handle offline state
}
```

### Listen to Connectivity Changes
```dart
ConnectivityService().connectivityStream.listen((isConnected) {
  if (isConnected) {
    print('Internet is back!');
  } else {
    print('Internet is lost!');
  }
});
```

### Manual No Internet Screen (for testing)
```dart
ConnectivityWrapper.showNoInternetScreen(context);
```

## Testing

### Simulate No Internet
1. Turn off WiFi and mobile data
2. The app will automatically show `NoInternetScreen`
3. Turn internet back on
4. The app will automatically return to normal

### Test API Network Errors
1. Keep internet on but make API calls to an unreachable server
2. The app will show `NoInternetScreen` when API calls fail
3. Turn internet back on
4. The app will automatically return to normal

### Test Retry Button
1. Go to `NoInternetScreen`
2. Press the "Retry" button
3. If internet is available, it navigates back
4. If no internet, shows error message

## Benefits

1. **Automatic Detection**: No manual checks needed
2. **User-Friendly**: Clear UI when offline
3. **App Protection**: Prevents crashes from network errors
4. **Seamless Experience**: Automatic recovery when online
5. **Consistent**: Same behavior across the entire app

## Configuration

### Customize NoInternetScreen
Edit `lib/screens/no_internet_screen.dart` to:
- Change the UI design
- Modify error messages
- Add custom retry logic

### Customize ConnectivityService
Edit `lib/services/connectivity_service.dart` to:
- Change connectivity check frequency
- Add custom connectivity logic
- Modify error handling

### Customize Interceptor
Edit `lib/network/interceptors/internet_check_interceptor.dart` to:
- Change when requests are rejected
- Add custom error handling
- Modify retry logic
