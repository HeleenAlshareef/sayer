import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sayer/common/theme/colors.dart';
import 'package:sayer/features/showroom/ui/widget/dropdown_field.dart';

class FilterWidget extends StatelessWidget {
  final List<String?> cities;
  final List<String?> statuses;
  final String? selectedCity;
  final String? selectedStatus;
  final ValueChanged<String?> onCityChanged;
  final ValueChanged<String?> onStatusChanged;

  final Color? borderColor;
  final Color? focusedBorderColor;
  final Color? dropdownBackgroundColor;
  final Color? hintColor;
  final Color? textColor;
  final Color? iconColor;
  final double? borderWidth;
  final double? focusedBorderWidth;
  final double? dropdownHeight;

  const FilterWidget({
    super.key,
    required this.cities,
    required this.statuses,
    required this.selectedCity,
    required this.selectedStatus,
    required this.onCityChanged,
    required this.onStatusChanged,
    this.borderColor,
    this.focusedBorderColor,
    this.dropdownBackgroundColor,
    this.hintColor,
    this.textColor,
    this.iconColor,
    this.borderWidth,
    this.focusedBorderWidth,
    this.dropdownHeight,
  });

  @override
  Widget build(BuildContext context) {
    final h = dropdownHeight ?? 64.h; // رفعت الارتفاع الافتراضي

    final cityItems = cities.map((e) => e ?? 'الكل').toList();
    final statusItems = statuses.map((e) => e ?? 'الكل').toList();

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: LabeledDropdown(
                label: 'المدينة',
                height: h,
                child: AppDropdownField(
                  hintText: 'الكل',
                  items: cityItems,
                  value: selectedCity ?? 'الكل',
                  onChanged: (v) => onCityChanged(v == 'الكل' ? null : v),
                  borderColor: borderColor,
                  focusedBorderColor: focusedBorderColor,
                  dropdownBackgroundColor: dropdownBackgroundColor,
                  hintColor: hintColor,
                  textColor: textColor,
                  iconColor: iconColor,
                  borderWidth: borderWidth ?? 1.0,
                  focusedBorderWidth: focusedBorderWidth ?? 1.5,
                ),
              ),
            ),
            SizedBox(width: 12.w),

            Expanded(
              child: LabeledDropdown(
                label: 'حالة الطلب',
                height: h,
                child: AppDropdownField(
                  hintText: 'الكل',
                  items: statusItems,
                  value: selectedStatus ?? 'الكل',
                  onChanged: (v) => onStatusChanged(v == 'الكل' ? null : v),
                  borderColor: borderColor,
                  focusedBorderColor: focusedBorderColor,
                  dropdownBackgroundColor: dropdownBackgroundColor,
                  hintColor: hintColor,
                  textColor: textColor,
                  iconColor: iconColor,
                  borderWidth: borderWidth ?? 1.0,
                  focusedBorderWidth: focusedBorderWidth ?? 1.5,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class LabeledDropdown extends StatelessWidget {
  final String label;
  final double height;
  final Widget child;

  const LabeledDropdown({
    required this.label,
    required this.height,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 4.h),
          child: Text(
            label,
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: AppColors.darkerGrey),
          ),
        ),
        SizedBox(height: height, child: child),
      ],
    );
  }
}
