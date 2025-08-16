import 'package:flutter/material.dart';
import 'package:sayer/common/theme/colors.dart';

class AppBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const AppBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final Color selected = AppColors.primary;
    final Color unselected = AppColors.darkerGrey;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.grey,
        boxShadow: [
          BoxShadow(
            blurRadius: 6,
            spreadRadius: 0,
            offset: const Offset(0, -2),
            color: AppColors.black.withOpacity(0.08),
          ),
        ],
      ),

      child: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onTap,
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColors.white,
        elevation: 0,

        selectedItemColor: selected,
        unselectedItemColor: unselected,

        iconSize: 20,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.add_business_outlined),
            activeIcon: Icon(Icons.add_business, size: 20),
            label: 'معرض جديد',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long_outlined),
            activeIcon: Icon(Icons.receipt_long, size: 20),
            label: 'الطلبات',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.storefront_outlined),
            activeIcon: Icon(Icons.storefront, size: 20),
            label: 'المعارض',
          ),
        ],

        selectedFontSize: 10,
        unselectedFontSize: 10,
        selectedLabelStyle: TextStyle(
          fontWeight: FontWeight.w500,
          color: selected,
        ),
        unselectedLabelStyle: TextStyle(
          fontWeight: FontWeight.w500,
          color: unselected,
        ),
        showUnselectedLabels: true,
      ),
    );
  }
}
