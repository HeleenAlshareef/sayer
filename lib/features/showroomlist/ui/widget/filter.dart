import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sayer/common/theme/colors.dart';
import 'package:sayer/features/showroomlist/ui/widget/dropdown_field.dart';

class FilterWidget extends StatelessWidget {
  const FilterWidget({
    super.key,
    required this.cities,
    required this.brands,
    this.featuredBrands,
    required this.selectedCity,
    required this.selectedBrand,
    required this.selectedFeaturedBrand,
    required this.onCityChanged,
    required this.onBrandChanged,
    required this.onFeaturedBrandChanged,
    this.gap = 12,
    this.fieldHeight = 50,
  });

  final List<String?> cities;
  final List<String?> brands;
  final List<String?>? featuredBrands;

  final String? selectedCity;
  final String? selectedBrand;
  final String? selectedFeaturedBrand;

  final ValueChanged<String?> onCityChanged;
  final ValueChanged<String?> onBrandChanged;
  final ValueChanged<String?> onFeaturedBrandChanged;

  final double gap;
  final double fieldHeight;

  @override
  Widget build(BuildContext context) {
    final cityItems = ['الكل', ...cities.whereType<String>()];
    final brandItems = ['الكل', ...brands.whereType<String>()];
    final featuredItems = [
      'الكل',
      ...((featuredBrands ?? brands).whereType<String>()),
    ];

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Row(
        children: [
          Expanded(
            child: LabeledDropdown(
              label: 'المدينة',
              child: AppDropdownField(
                items: cityItems,
                value: selectedCity ?? 'الكل',
                onChanged: (v) => onCityChanged(v == 'الكل' ? null : v),
                hintText: 'الكل',
                fieldHeight: fieldHeight.h,
                borderRadius: 10.r,
                borderColor: AppColors.darkGrey,
                focusedBorderColor: AppColors.primary,
                hintColor: AppColors.darkerGrey,
                textColor: AppColors.darkerGrey,
                iconColor: AppColors.darkGrey,
              ),
            ),
          ),
          SizedBox(width: gap.w),
          Expanded(
            child: LabeledDropdown(
              label: 'العلامة التجارية',
              child: AppDropdownField(
                items: brandItems,
                value: selectedBrand ?? 'الكل',
                onChanged: (v) => onBrandChanged(v == 'الكل' ? null : v),
                hintText: 'الكل',
                fieldHeight: fieldHeight.h,
                borderRadius: 10.r,
                borderColor: AppColors.darkGrey,
                focusedBorderColor: AppColors.primary,
                hintColor: AppColors.darkerGrey,
                textColor: AppColors.darkerGrey,
                iconColor: AppColors.darkGrey,
              ),
            ),
          ),
          SizedBox(width: gap.w),
          Expanded(
            child: LabeledDropdown(
              label: 'العلامة المميزة',
              child: AppDropdownField(
                items: featuredItems,
                value: selectedFeaturedBrand ?? 'الكل',
                onChanged:
                    (v) => onFeaturedBrandChanged(v == 'الكل' ? null : v),
                hintText: 'الكل',
                fieldHeight: fieldHeight.h,
                borderRadius: 10.r,
                borderColor: AppColors.darkGrey,
                focusedBorderColor: AppColors.primary,
                hintColor: AppColors.darkerGrey,
                textColor: AppColors.darkerGrey,
                iconColor: AppColors.darkGrey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LabeledDropdown extends StatelessWidget {
  const LabeledDropdown({required this.label, required this.child});

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 8.h),
          child: Text(
            label,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.darkerGrey,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        SizedBox(
          height: 50.h,
          width: double.infinity,
          child: Align(alignment: Alignment.center, child: child),
        ),
      ],
    );
  }
}
