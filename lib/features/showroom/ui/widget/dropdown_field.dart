import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sayer/common/theme/colors.dart';

class AppDropdownField extends StatelessWidget {
  final String? hintText;
  final List<String> items;
  final String? value;
  final ValueChanged<String?> onChanged;

  final Color? hintColor;
  final Color? textColor;
  final Color? borderColor;
  final Color? focusedBorderColor;
  final Color? fillColor;
  final Color? iconColor;

  final Color? dropdownBackgroundColor;
  final double? menuMaxHeight;
  final double? itemHeight;
  final BorderRadius? popupBorderRadius;

  const AppDropdownField({
    super.key,
    this.hintText,
    required this.items,
    this.value,
    required this.onChanged,
    this.hintColor,
    this.textColor,
    this.borderColor,
    this.focusedBorderColor,
    this.fillColor,
    this.iconColor,
    this.dropdownBackgroundColor,
    this.menuMaxHeight,
    this.itemHeight,
    this.popupBorderRadius,
    required double borderWidth,
    required double focusedBorderWidth,
  });

  @override
  Widget build(BuildContext context) {
    final Color finalTextColor = textColor ?? AppColors.darkerGrey;
    final Color finalHintColor = hintColor ?? AppColors.black;
    final Color finalBorderColor = borderColor ?? AppColors.grey;
    final Color finalFocusedBorderColor =
        focusedBorderColor ?? AppColors.darkerGrey;
    final Color finalIconColor = iconColor ?? AppColors.darkGrey;

    final double finalItemHeight = (itemHeight ?? 48).h;
    final double finalMenuMaxHeight = (menuMaxHeight ?? 360).h;
    final Color finalDropdownBg = dropdownBackgroundColor ?? Colors.white;
    final BorderRadius finalPopupRadius =
        popupBorderRadius ?? BorderRadius.circular(10.r);

    final baseTextStyle = Theme.of(
      context,
    ).textTheme.bodyMedium?.copyWith(fontSize: 12.sp, color: finalTextColor);

    final baseHintStyle = Theme.of(
      context,
    ).textTheme.bodyMedium?.copyWith(fontSize: 14.sp, color: finalHintColor);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 6.h),
      child: SizedBox(
        width: double.infinity,
        height: 60.h,
        child: DropdownButtonFormField<String>(
          items:
              items.map((item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: SizedBox(
                    height: finalItemHeight,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(item, style: baseTextStyle),
                    ),
                  ),
                );
              }).toList(),
          value: value,
          onChanged: onChanged,
          isExpanded: true,
          dropdownColor: finalDropdownBg,
          menuMaxHeight: finalMenuMaxHeight,
          itemHeight: finalItemHeight,
          borderRadius: finalPopupRadius,
          icon: Icon(Icons.arrow_drop_down, color: finalIconColor),

          hint: Align(
            alignment: Alignment.centerRight,
            child: Text(hintText ?? '', style: baseHintStyle),
          ),

          selectedItemBuilder: (context) {
            return items.map((item) {
              return Align(
                alignment: Alignment.centerRight,
                child: Text(item, style: baseTextStyle),
              );
            }).toList();
          },

          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(16.w),
            filled: fillColor != null,
            fillColor: fillColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(color: finalBorderColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(color: finalBorderColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(
                color: finalFocusedBorderColor,
                width: 1.5,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
