import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sayer/common/theme/colors.dart';
import 'package:sayer/common/widgets/app_bar.dart';
import 'package:sayer/common/routing/routes.dart';
import 'package:sayer/features/showroom/ui/widget/showroom_form.dart';
import 'package:sayer/common/helpers/bar.dart';
import 'package:sayer/features/showroomlist/ui/widget/details.dart';

class ShowroomScreen extends StatefulWidget {
  const ShowroomScreen({super.key});

  @override
  State<ShowroomScreen> createState() => ShowroomScreenState();
}

class ShowroomScreenState extends State<ShowroomScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

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
                  ShowroomForm(
                    onSubmit: (name, phone, city, brands, featured, location) {
                      if (name.isEmpty ||
                          phone.isEmpty ||
                          city.isEmpty ||
                          brands.isEmpty ||
                          featured.isEmpty ||
                          location.isEmpty) {
                        return;
                      }

                      showroomList.add(
                        Showroom(
                          name: name,
                          phone: phone,
                          city: city,
                          brand: brands.join(', '),
                          featuredBrand: featured,
                          logoPath: '',
                          availableBrands: brands,
                          location: location,
                        ),
                      );

                      Navigator.pushNamed(context, Routes.showroomList);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
