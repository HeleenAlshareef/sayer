import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sayer/common/theme/colors.dart';
import 'package:sayer/features/showroomlist/ui/widget/filter.dart';
import 'package:sayer/features/showroomlist/ui/widget/lists.dart'; // لو غيّرته إلى list.dart عدّل هنا
import 'package:sayer/features/showroomlist/ui/widget/search.dart';

class ShowroomsListScreen extends StatefulWidget {
  const ShowroomsListScreen({super.key});

  @override
  State<ShowroomsListScreen> createState() => ShowroomsListScreenState();
}

class ShowroomsListScreenState extends State<ShowroomsListScreen> {
  final TextEditingController searchController = TextEditingController();
  final FocusNode searchFocus = FocusNode();
  bool showSearch = false;

  final List<String?> cities = ['الرياض', 'جدة', 'الخبر'];
  final List<String?> brands = ['تويوتا', 'هيونداي', 'مرسيدس'];
  final List<String?> featuredBrands = ['تويوتا', 'هيونداي', 'مرسيدس'];

  String? selectedCity;
  String? selectedBrand;
  String? selectedFeaturedBrand;

  void SearchChanged(String value) => setState(() {});

  @override
  void dispose() {
    searchController.dispose();
    searchFocus.dispose();
    super.dispose();
  }

  void toggleSearch() {
    setState(() => showSearch = !showSearch);
    if (showSearch) {
      Future.delayed(const Duration(milliseconds: 100), () {
        if (mounted) FocusScope.of(context).requestFocus(searchFocus);
      });
    } else {
      searchController.clear();
      SearchChanged('');
    }
  }

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
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: AppColors.darkerGrey,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                    Expanded(
                      child: Text(
                        'المعارض',
                        textAlign: TextAlign.center,
                        style: Theme.of(
                          context,
                        ).textTheme.titleMedium?.copyWith(
                          color: AppColors.darkerGrey,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.sp,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        showSearch ? Icons.close : Icons.search,
                        color: AppColors.darkerGrey,
                      ),
                      onPressed: toggleSearch,
                    ),
                  ],
                ),

                AnimatedCrossFade(
                  duration: const Duration(milliseconds: 200),
                  crossFadeState:
                      showSearch
                          ? CrossFadeState.showFirst
                          : CrossFadeState.showSecond,
                  firstChild: Padding(
                    padding: EdgeInsets.only(top: 16.h),
                    child: ShowroomSearchBar(
                      controller: searchController,
                      focusNode: searchFocus,
                      onChanged: SearchChanged,
                    ),
                  ),
                  secondChild: SizedBox(height: 8.h),
                ),

                SizedBox(height: 12.h),

                FilterWidget(
                  cities: cities,
                  brands: brands,
                  featuredBrands: featuredBrands,
                  selectedCity: selectedCity,
                  selectedBrand: selectedBrand,
                  selectedFeaturedBrand: selectedFeaturedBrand,
                  onCityChanged: (v) => setState(() => selectedCity = v),
                  onBrandChanged: (v) => setState(() => selectedBrand = v),
                  onFeaturedBrandChanged:
                      (v) => setState(() => selectedFeaturedBrand = v),
                ),

                SizedBox(height: 12.h),
                Expanded(
                  child: ShowroomGrid(
                    city: selectedCity,
                    brand: selectedBrand,
                    featuredBrand: selectedFeaturedBrand,
                    query: searchController.text.trim(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
