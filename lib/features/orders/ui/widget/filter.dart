import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sayer/features/showroomlist/ui/widget/dropdown_field.dart';

class FilterWidget extends StatelessWidget {
  final List<String?> fromList;
  final List<String?> statusList;
  final String? selectedFrom;
  final String? selectedStatus;
  final ValueChanged<String?> onFromChanged;
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
    required this.fromList,
    required this.statusList,
    required this.selectedFrom,
    required this.selectedStatus,
    required this.onFromChanged,
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
    final h = dropdownHeight ?? 56.h;
    final double fieldWidth = MediaQuery.of(context).size.width * 0.42;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: fieldWidth,
          height: h,
          child: ShowroomListDropdownField(
            hintText: 'المصدر',
            items: ['الكل', ...fromList.whereType<String>()],
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
        SizedBox(width: 6.w),
        SizedBox(
          width: fieldWidth,
          height: h,
          child: ShowroomListDropdownField(
            hintText: 'الحالة',
            items: ['الكل', ...statusList.whereType<String>()],
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
      ],
    );
  }
}
