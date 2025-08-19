/*import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sayer/common/theme/colors.dart';
import 'package:sayer/common/routing/routes.dart';

class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.all(10),
        children: [
          SizedBox(height: 120.h), 

          buildMenuItem(
            icon: Icons.store,
            text: 'المعارض',
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, Routes.showroomList);
            },
          ),
          buildMenuItem(
            icon: Icons.info,
            text: 'الطلبات',
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, Routes.orders);
            },
          ),
        ],
      ),
    );
  }

  Widget buildMenuItem({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 20.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            Text(
              text,
              style: TextStyle(
                fontSize: 12.sp,
                color: AppColors.darkerGrey,
                fontWeight: FontWeight.w500,
              ),
            ),

            Icon(icon, size: 20.sp, color: AppColors.darkerGrey),
          ],
        ),
      ),
    );
  }
}*/
