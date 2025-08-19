import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sayer/common/helpers/notification.dart';
import 'package:sayer/common/routing/app_router.dart';
import 'package:sayer/sayer_showroom.dart';
import 'package:sayer/firebase_options.dart';

Future<void> main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();

    // Initialize Firebase with proper options
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    // Initialize notifications
    await NotificationHelper.initialize();

    // Run the app
    runApp(SayerShowroom(appRouter: AppRouter()));
  } catch (e) {
    // In case of initialization error, run app without Firebase
    debugPrint('Firebase initialization error: $e');
    runApp(SayerShowroom(appRouter: AppRouter()));
  }
}
