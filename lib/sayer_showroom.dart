import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sayer/common/routing/routes.dart';
import 'common/routing/app_router.dart.dart';

class SayerShowroom extends StatelessWidget {
  final AppRouter appRouter;
  const SayerShowroom({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(430, 932),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: appRouter.generateRoutes,
        initialRoute: Routes.showroom,
        theme: ThemeData(fontFamily: "Montserrat"),
        supportedLocales: [Locale('ar'), Locale('en')],
        localizationsDelegates: [
          GlobalCupertinoLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        locale: Locale('ar'),
      ),
    );
  }
}
