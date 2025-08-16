import 'package:flutter/material.dart';
import 'package:sayer/common/routing/routes.dart';
import 'package:sayer/features/showroom/ui/showroom_screen.dart';
import 'package:sayer/features/orders/ui/orders_screen.dart';
import 'package:sayer/features/showroomlist/ui/showrooms_list_screen.dart';

const List<String> bottomTabs = <String>[
  Routes.showroom,
  Routes.orders,
  Routes.showroomList,
];

Widget _pageForIndex(int index) {
  switch (index) {
    case 0:
      return const ShowroomScreen();
    case 1:
      return const OrdersScreen();
    case 2:
      return const ShowroomsListScreen();
    default:
      return const SizedBox.shrink();
  }
}

void handleBottomTap(BuildContext context, int currentIndex, int tappedIndex) {
  if (tappedIndex == currentIndex) return;
  if (tappedIndex < 0 || tappedIndex >= bottomTabs.length) return;

  final targetName = bottomTabs[tappedIndex];
  final page = _pageForIndex(tappedIndex);

  Navigator.of(context).pushReplacement(
    PageRouteBuilder(
      settings: RouteSettings(name: targetName),
      pageBuilder: (_, __, ___) => page,
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero,
      transitionsBuilder: (_, __, ___, child) => child,
    ),
  );
}
