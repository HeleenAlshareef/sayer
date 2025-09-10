import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sayer/common/theme/colors.dart';

class StatusDropdown extends StatelessWidget {
  final String phone;
  final String currentStatus;
  final ValueChanged<String>? onChanged;

  const StatusDropdown({
    super.key,
    required this.phone,
    required this.currentStatus,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final statuses = ['جديد', 'جارٍ التواصل', 'تم الإغلاق'];

    return Material(
      color: Colors.transparent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children:
            statuses.map((status) {
              final isSelected = status == currentStatus;
              final Color selectedColor = getStatusColor(status);

              return InkWell(
                onTap: () => onChanged?.call(status),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 12.h,
                  ),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      status,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color:
                            isSelected ? selectedColor : AppColors.darkerGrey,
                        fontWeight:
                            isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
      ),
    );
  }

  Color getStatusColor(String status) {
    switch (status) {
      case 'جديد':
        return Colors.green;
      case 'جارٍ التواصل':
        return Color.fromARGB(255, 213, 179, 27);
      case 'تم الإغلاق':
        return Color.fromARGB(255, 193, 30, 30);
      default:
        return AppColors.primary;
    }
  }
}
