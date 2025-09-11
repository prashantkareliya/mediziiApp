import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

void initializeLocalNotifications() {
  const AndroidInitializationSettings androidInitializationSettings = AndroidInitializationSettings('@mipmap/ic_launcher');

  final DarwinInitializationSettings iosInitializationSettings = DarwinInitializationSettings();

  InitializationSettings initializationSettings =
      InitializationSettings(android: androidInitializationSettings, iOS: iosInitializationSettings);

  flutterLocalNotificationsPlugin.initialize(initializationSettings);
}

Future<void> showFlutterLocalNotification(RemoteMessage message) async {
  const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
    'channel_id',
    'channel_name',
    importance: Importance.high,
    priority: Priority.high,
  );

  const DarwinNotificationDetails iosDetails = DarwinNotificationDetails();

  const NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidDetails);

  await flutterLocalNotificationsPlugin.show(
    0, // Notification ID
    message.notification?.title,
    message.notification?.body,
    platformChannelSpecifics,
  );
}
