import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sayer/features/showroom/ui/widget/dropdown_field.dart';

class FilterWidget extends StatelessWidget {
  final List<String?> fromList;
  final String? selectedFrom;
  final ValueChanged<String?> onFromChanged;

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
    required this.fromList,
    required this.selectedFrom,
    required this.onFromChanged,
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
    final h = dropdownHeight ?? 64.h;
    final items = fromList.map((e) => e ?? 'الكل').toList();

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: SizedBox(
                height: h,
                child: AppDropdownField(
                  hintText: 'الكل',
                  items: items,
                  value: selectedFrom ?? 'الكل',
                  onChanged: (v) => onFromChanged(v == 'الكل' ? null : v),
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
