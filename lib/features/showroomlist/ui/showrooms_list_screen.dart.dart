import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sayer/common/theme/colors.dart';
import 'package:sayer/features/showroomlist/ui/widget/lists.dart';
import 'package:sayer/features/showroomlist/ui/widget/search..dart';

class ShowroomsListScreen extends StatefulWidget {
  const ShowroomsListScreen({super.key});

  @override
  State<ShowroomsListScreen> createState() => _ShowroomsListScreenState();
}

class _ShowroomsListScreenState extends State<ShowroomsListScreen> {
  final TextEditingController searchController = TextEditingController();

  void _onSearchChanged(String value) {
    print("بحث: $value");
    // filter
  }

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
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
                  onPressed: () => Navigator.pop(context),
                ),
                SizedBox(height: 10.h),

                Center(
                  child: Image.asset(
                    'assets/images/logo.png',
                    width: 50.w,
                    height: 50.h,
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: 20.h),

                ShowroomSearchBar(
                  controller: searchController,
                  onChanged: _onSearchChanged,
                ),

                SizedBox(height: 30.h),

                Center(
                  child: Text(
                    "قائمة المعارض",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppColors.darkerGrey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                SizedBox(height: 20.h),
                Expanded(child: ShowroomGrid()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
