import 'package:flutter/material.dart';
import 'package:sayer/common/routing/routes.dart';
import 'package:sayer/features/showroomlist/ui/showrooms_list_screen.dart.dart';
import 'package:sayer/features/showroom/ui/showroom_screen.dart';

class AppRouter {
  Route? generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case Routes.showroom:
        return MaterialPageRoute(builder: (_) => ShowroomScreen());

      case Routes.showroomList:
        return MaterialPageRoute(builder: (_) => ShowroomsListScreen());

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(body: Center(child: Text("no path"))),
        );
    }
  }
}
