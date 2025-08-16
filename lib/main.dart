import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sayer/common/helpers/notification.dart';
import 'package:sayer/common/routing/app_router.dart';
import 'package:sayer/sayer_showroom.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await NotificationHelper.initialize();
  runApp(SayerShowroom(appRouter: AppRouter()));
}
