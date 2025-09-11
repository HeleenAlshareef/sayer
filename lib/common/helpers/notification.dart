import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:sayer/common/widgets/app_notification.dart';

class NotificationHelper {
  static Future<void> initialize(GlobalKey<NavigatorState> navigatorKey) async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    if (Platform.isIOS) {
      await messaging.requestPermission();
    }

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      final notification = message.notification;
      if (notification != null && navigatorKey.currentContext != null) {
        navigatorKey.currentContext!.showNotification(
          message: notification.title ?? 'طلب جديد',
          icon: Icons.notifications,
        );
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("فتح التطبيق من إشعار: ${message.notification?.title}");
    });
  }

  static Future<void> printFCMToken() async {
    try {
      String? token = await FirebaseMessaging.instance.getToken();
      print("FCM Token: $token");
    } catch (e) {
      print("Failed to get FCM Token: $e");
    }
  }
}
