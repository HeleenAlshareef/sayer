import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sayer/common/helpers/ios_widget.dart';
import 'package:sayer/common/theme/colors.dart';
import 'package:sayer/common/widgets/app_bar.dart';
import 'package:sayer/features/showroom/ui/widget/showroom_form.dart';
import 'package:sayer/common/helpers/bar.dart';

class ShowroomScreen extends StatefulWidget {
  const ShowroomScreen({super.key});

  @override
  State<ShowroomScreen> createState() => ShowroomScreenState();
}

class ShowroomScreenState extends State<ShowroomScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    fetchAndSendOrderStats();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: const Alignment(0.0, -0.2),
            colors: [AppColors.gradientStart, AppColors.gradientend],
          ),
        ),
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: Colors.transparent,
          bottomNavigationBar: AppBottomNav(
            currentIndex: 0,
            onTap: (i) => handleBottomTap(context, 0, i),
          ),
          body: SafeArea(
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
        ),
      ),
    );
  }
}
