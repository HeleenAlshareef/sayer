import 'package:flutter/material.dart';
import 'package:sayer/common/routing/app_router.dart.dart';
import 'package:sayer/sayer_showroom.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  ///
  await NotificationHelper.initialize();

  runApp(SayerShowroom(appRouter: AppRouter()));
}
