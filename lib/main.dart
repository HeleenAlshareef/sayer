import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sayer/common/helpers/notification.dart';
import 'package:sayer/common/routing/app_router.dart';
import 'package:sayer/sayer_showroom.dart';
import 'package:sayer/firebase_options.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();

    // Initialize Firebase with proper options
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    // Initialize notifications (with navigatorKey for in-app UI)
    await NotificationHelper.initialize(navigatorKey);

    // Print FCM token to debug console (only the token)
    await NotificationHelper.printFCMToken();

    // Run the app
    runApp(
      SayerShowroom(
        appRouter: AppRouter(),
        navigatorKey: navigatorKey, 
      ),
    );
    
  } catch (e) {
    // In case of initialization error, run app without Firebase
    debugPrint('Firebase initialization error: $e');
    runApp(
      SayerShowroom(
        appRouter: AppRouter(),
        navigatorKey: navigatorKey,
      ),
    );
  }
}