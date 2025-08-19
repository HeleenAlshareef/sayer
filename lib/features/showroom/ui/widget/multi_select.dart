import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';
import 'package:sayer/common/theme/colors.dart';

class MultiSelect extends StatelessWidget {
  final String hintText;
  final List<String> items;
  final List<String> selectedValues;
  final void Function(List<String>) onConfirm;

  final Color? hintColor;
  final Color? textColor;
  final Color? borderColor;
  final Color? focusedBorderColor;
  final Color? fillColor;
  final Color? iconColor;
  final double? dialogHeight;
  final TextStyle? confirmTextStyle;
  final TextStyle? cancelTextStyle;

  const MultiSelect({
    super.key,
    required this.hintText,
    required this.items,
    required this.selectedValues,
    required this.onConfirm,
    this.hintColor,
    this.textColor,
    this.borderColor,
    this.focusedBorderColor,
    this.fillColor,
    this.iconColor,
    this.dialogHeight,
    this.confirmTextStyle,
    this.cancelTextStyle,
  });

  @override
  Widget build(BuildContext context) {
    final Color finalTextColor = textColor ?? AppColors.darkerGrey;
    final Color finalHintColor = hintColor ?? AppColors.black;
    final Color finalBorderColor = borderColor ?? AppColors.grey;
    final Color finalFocusedBorderColor =
        focusedBorderColor ?? AppColors.darkerGrey;
    final Color finalIconColor = iconColor ?? AppColors.darkGrey;

    final TextStyle? baseTextStyle = Theme.of(
      context,
    ).textTheme.bodyMedium?.copyWith(fontSize: 12.sp, color: finalTextColor);
    final TextStyle? baseHintStyle = Theme.of(
      context,
    ).textTheme.bodyMedium?.copyWith(fontSize: 14.sp, color: finalHintColor);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 6.h),
      child: Container(
        width: double.infinity,
        height: 60.h,
        padding: EdgeInsets.symmetric(horizontal: 6.w),
        decoration: BoxDecoration(
          color: fillColor,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: finalBorderColor),
        ),
        alignment: Alignment.centerRight,

        child: Directionality(
          textDirection: TextDirection.rtl,
          child: MultiSelectDialogField<String>(
            items: items.map((e) => MultiSelectItem<String>(e, e)).toList(),

            dialogHeight: (dialogHeight ?? 500).h,
            backgroundColor: Colors.white,

            title: const SizedBox.shrink(),
            confirmText: Text(
              'اختيار',
              style:
                  confirmTextStyle ??
                  Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            cancelText: Text(
              'إلغاء',
              style:
                  cancelTextStyle ??
                  Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
            ),

            listType: MultiSelectListType.LIST,
            itemsTextStyle: baseTextStyle,
            selectedItemsTextStyle: baseTextStyle?.copyWith(
              fontWeight: FontWeight.w600,
            ),
            selectedColor: finalFocusedBorderColor,
            checkColor: Colors.white,

            decoration: const BoxDecoration(color: Colors.transparent),

            buttonIcon: Icon(Icons.arrow_drop_down, color: finalIconColor),

            buttonText: Text(
              selectedValues.isEmpty ? hintText : selectedValues.join(', '),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: selectedValues.isEmpty ? baseHintStyle : baseTextStyle,
            ),

            chipDisplay: MultiSelectChipDisplay.none(),

            onConfirm: (values) => onConfirm(values.cast<String>()),
          ),
        ),
      ),
    );
  }
}
