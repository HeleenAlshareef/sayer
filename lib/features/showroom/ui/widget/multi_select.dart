import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:sayer/common/theme/colors.dart';

class MultiSelect extends StatelessWidget {
  final String hintText;
  final List<String> items;
  final List<String> selectedValues;
  final void Function(List<String>) onConfirm;

  const MultiSelect({
    super.key,
    required this.hintText,
    required this.items,
    required this.selectedValues,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 6.h),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 4.h),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.darkerGrey),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: MultiSelectDialogField(
          items: items.map((e) => MultiSelectItem(e, e)).toList(),
          selectedColor: AppColors.primary,
          dialogHeight: 500.h,
          decoration: const BoxDecoration(color: Colors.transparent),
          buttonIcon: const Icon(Icons.arrow_drop_down),
          buttonText: Text(
            selectedValues.isEmpty ? hintText : selectedValues.join(', '),
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: 14.sp,
              color: AppColors.black,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          onConfirm: (values) => onConfirm(values.cast<String>()),
        ),
      ),
    );
  }
}
