import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sayer/common/theme/colors.dart';
import 'details.dart';

class ShowroomGrid extends StatelessWidget {
  final String? city;
  final String? brand;
  final String? featuredBrand;
  final String? query;
  final Color tileFrameColor;

  const ShowroomGrid({
    super.key,
    this.city,
    this.brand,
    this.featuredBrand,
    this.query,
    this.tileFrameColor = Colors.transparent,
  });

  @override
  Widget build(BuildContext context) {
    final String searchTerm = (query ?? '').trim();

    final List filteredShowrooms =
        showroomList.where((s) {
          final matchesFilters =
              (city == null || s.city == city) &&
              (brand == null || s.brand == brand) &&
              (featuredBrand == null || s.featuredBrand == featuredBrand);

          final matchesSearch =
              searchTerm.isEmpty ||
              [
                s.name,
                s.city,
                s.brand,
                s.featuredBrand,
              ].any((t) => t.toString().contains(searchTerm));

          return matchesFilters && matchesSearch;
        }).toList();

    return GridView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      physics: const BouncingScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.82,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: filteredShowrooms.length,
      itemBuilder: (context, index) {
        final showroom = filteredShowrooms[index];

        return GestureDetector(
          onTap: () => showShowroomDetailsDialog(context, showroom),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(6.w),
                  decoration: BoxDecoration(
                    color: tileFrameColor,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(20.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.10),
                          blurRadius: 18,
                          offset: const Offset(0, 8),
                        ),
                        BoxShadow(
                          color: Colors.black.withOpacity(0.03),
                          blurRadius: 36,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.all(12.w),
                        child:
                            showroom.logoPath.isNotEmpty
                                ? Image.asset(
                                  showroom.logoPath,
                                  fit: BoxFit.contain,
                                )
                                : Icon(
                                  Icons.store,
                                  size: 48,
                                  color: AppColors.primary,
                                ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 6.h),
              Text(
                showroom.name,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.darkerGrey,
                  fontSize: 12.sp,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void showShowroomDetailsDialog(BuildContext context, dynamic showroom) {
    showDialog(
      context: context,
      builder:
          (_) => Directionality(
            textDirection: TextDirection.rtl,
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24.r),
              ),
              insetPadding: EdgeInsets.symmetric(
                horizontal: 24.w,
                vertical: 24.h,
              ),
              titlePadding: EdgeInsets.fromLTRB(24.w, 24.h, 24.w, 0),
              contentPadding: EdgeInsets.fromLTRB(24.w, 16.h, 24.w, 8.h),
              actionsPadding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 12.h),
              backgroundColor: AppColors.white,
              title: Text(
                showroom.name,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: AppColors.darkerGrey,
                  fontSize: 20.sp,
                ),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child:
                        showroom.logoPath.isNotEmpty
                            ? Image.asset(showroom.logoPath, height: 80.h)
                            : Icon(
                              Icons.store,
                              size: 48,
                              color: AppColors.primary,
                            ),
                  ),
                  SizedBox(height: 16.h),
                  buildInfoRow(context, 'اسم المعرض', showroom.name),
                  buildInfoRow(
                    context,
                    'العلامة التجارية المميزة',
                    showroom.featuredBrand,
                  ),
                  if ((showroom.phone ?? '').toString().isNotEmpty)
                    buildInfoRow(context, 'رقم التواصل', showroom.phone),
                  buildInfoRow(context, 'المدينة', showroom.city),
                ],
              ),
              actionsAlignment: MainAxisAlignment.start,
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(
                    'إغلاق',
                    style: TextStyle(color: AppColors.primary),
                  ),
                ),
              ],
            ),
          ),
    );
  }

  Widget buildInfoRow(BuildContext context, String label, dynamic value) {
    final String textValue = (value ?? '').toString().trim();
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: RichText(
        textAlign: TextAlign.right,
        text: TextSpan(
          children: [
            TextSpan(
              text: '$label: ',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: Colors.black87,
                fontSize: 13.sp,
              ),
            ),
            TextSpan(
              text: textValue.isEmpty ? '-' : textValue,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w400,
                color: AppColors.black,
                fontSize: 12.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
