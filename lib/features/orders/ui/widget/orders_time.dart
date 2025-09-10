import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sayer/common/theme/colors.dart';

class OrderTime extends StatelessWidget {
  final DateTime? timestamp;

  const OrderTime({super.key, required this.timestamp});

  @override
  Widget build(BuildContext context) {
    if (timestamp == null) return const SizedBox.shrink();

    return Row(
      textDirection: TextDirection.rtl,
      children: [
        Text(
          formatAbsolute(timestamp!),
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            fontSize: 11.sp,
            color: AppColors.darkerGrey,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  String formatAbsolute(DateTime dt) {
    String two(int n) => n.toString().padLeft(2, '0');
    return '${dt.year}-${two(dt.month)}-${two(dt.day)} ${two(dt.hour)}:${two(dt.minute)}';
  }
}
