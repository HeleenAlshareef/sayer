import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationHelper {
  static Future<void> initialize() async {
    if (Platform.isIOS) {
      await FirebaseMessaging.instance.requestPermission();
    }

    //FirebaseMessaging.onMessage.listen((message) {});
    //FirebaseMessaging.onMessageOpenedApp.listen((message) {});
  }

  static Future<void> printFCMToken() async {
    try {
      final token = await FirebaseMessaging.instance.getToken();
      if (token != null) {
        print(token);
      }
    } catch (_) {}
  }
}
