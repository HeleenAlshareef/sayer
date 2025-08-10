import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sayer/common/theme/colors.dart';
import 'package:sayer/features/showroom/ui/widget/menu.dart';
import 'package:sayer/features/showroom/ui/widget/showroom_form.dart';

class ShowroomScreen extends StatefulWidget {
  const ShowroomScreen({super.key});

  @override
  State<ShowroomScreen> createState() => _ShowroomScreenState();
}

class _ShowroomScreenState extends State<ShowroomScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: const Alignment(0.0, -0.2),
          colors: [AppColors.gradientStart, AppColors.gradientend],
        ),
      ),
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.transparent,
        drawer: const Menu(),
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 20.h, right: 20.w),
                child: Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: const Icon(Icons.menu, size: 30),
                    color: AppColors.darkerGrey,
                    onPressed: () {
                      _scaffoldKey.currentState?.openDrawer();
                    },
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 40.h),
                      Image.asset(
                        'assets/images/logo.png',
                        width: 120,
                        height: 120,
                      ),
                      SizedBox(height: 30.h),
                      Text(
                        "قم بإدخال بيانات المعرض",
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppColors.darkerGrey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 40.h),
                      const ShowroomForm(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
