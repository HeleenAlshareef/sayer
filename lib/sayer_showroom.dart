import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sayer/common/routing/routes.dart';
import 'common/routing/app_router.dart';

class SayerShowroom extends StatelessWidget {
  final AppRouter appRouter;
  final GlobalKey<NavigatorState> navigatorKey;

  const SayerShowroom({
    super.key,
    required this.appRouter,
    required this.navigatorKey, 
  });

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(430, 932),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        onGenerateRoute: appRouter.generateRoutes,
        initialRoute: Routes.showroom,
        theme: ThemeData(fontFamily: "Montserrat"),
        supportedLocales: const [Locale('ar'), Locale('en')],
        localizationsDelegates: const [
          GlobalCupertinoLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        locale: const Locale('ar'),
        localeResolutionCallback: (locale, supportedLocales) {
          for (var supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == locale?.languageCode) {
              return supportedLocale;
            }
          }
          return supportedLocales.first;
        },
      ),
    );
  }
}