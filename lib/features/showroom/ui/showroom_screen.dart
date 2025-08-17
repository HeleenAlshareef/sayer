import 'package:flutter/material.dart';
import 'package:sayer/common/theme/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sayer/features/showroom/ui/widget/showroom_form.dart';

class ShowroomScreen extends StatelessWidget {
  const ShowroomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment(0.0, -0.2),
          colors: [AppColors.gradientStart, AppColors.gradientend],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 40.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: SizedBox(
                    width: 120,
                    height: 120,
                    child: Image.asset('assets/images/logo.png'),
                  ),
                ),
                SizedBox(height: 30.h),
                Center(
                  child: Text(
                    "قم بإدخال بيانات المعرض",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppColors.darkerGrey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 40.h),
                ShowroomForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
