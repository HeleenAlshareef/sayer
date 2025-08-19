import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationHelper {
  static final notifications = FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    try {
      const DarwinInitializationSettings iosInit = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
      );

      const InitializationSettings initSettings = InitializationSettings(
        iOS: iosInit,
      );

      final bool? initialized = await notifications.initialize(initSettings);
      debugPrint('Notifications initialized: $initialized');
    } catch (e) {
      debugPrint('Error initializing notifications: $e');
      rethrow;
    }
  }

  static Future<void> showNotification(String title, String body) async {
    const DarwinNotificationDetails iosDetails = DarwinNotificationDetails();

    const NotificationDetails platformDetails = NotificationDetails(
      iOS: iosDetails,
    );

    await notifications.show(0, title, body, platformDetails);
  }
}
