import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class NotificationHelper {
  static Future<void> initialize(GlobalKey<NavigatorState> navigatorKey) async {
    final FirebaseMessaging messaging = FirebaseMessaging.instance;

    // طلب الصلاحيات للـ iOS
    if (Platform.isIOS) {
      await messaging.requestPermission(alert: true, badge: true, sound: true);
    }

    // طباعة التوكن أول مرة
    String? token = await messaging.getToken();
    if (token != null) {
      print("📲 FCM Token: $token");
    }

    // في حال تحديث التوكن
    messaging.onTokenRefresh.listen((newToken) {
      print("🔄 Token refreshed: $newToken");
    });

    // Foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      final notification = message.notification;
      if (notification != null) {
        print(
          "✅ Foreground notification received: "
          "${notification.title} - ${notification.body}",
        );
      }
    });

    // Background / Terminated
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print(
        "✅ User opened app from notification: ${message.notification?.title}",
      );
    });
  }
}
