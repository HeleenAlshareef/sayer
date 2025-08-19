import 'package:flutter/material.dart';
import 'package:sayer/common/theme/colors.dart';

class ShowroomListDropdownField extends StatelessWidget {
  const ShowroomListDropdownField({
    super.key,
    required this.items,
    required this.value,
    required this.onChanged,
    this.hintText = 'الكل',

    this.fieldHeight = 50,
    this.fontSize = 14,
    this.borderRadius = 14.0,

    this.borderColor,
    this.focusedBorderColor,
    this.dropdownBackgroundColor,
    this.hintColor,
    this.textColor,
    this.iconColor,
    this.borderWidth = 1.2,
    this.focusedBorderWidth = 1.8,

    this.menuMaxHeight = 320.0,

    this.selectedMaxLines = 2,
    this.menuItemMaxLines = 2,
    this.horizontalPadding = 16,
  });

  final List<String> items;
  final String? value;
  final ValueChanged<String?> onChanged;
  final String hintText;

  final double fieldHeight;
  final double fontSize;
  final double borderRadius;
  final Color? borderColor;
  final Color? focusedBorderColor;
  final Color? dropdownBackgroundColor;
  final Color? hintColor;
  final Color? textColor;
  final Color? iconColor;
  final double borderWidth;
  final double focusedBorderWidth;
  final double menuMaxHeight;

  final int selectedMaxLines;
  final int menuItemMaxLines;
  final double horizontalPadding;

  @override
  Widget build(BuildContext context) {
    final baseBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius),
      borderSide: BorderSide(
        color: borderColor ?? AppColors.black,
        width: borderWidth,
      ),
    );

    final focusBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius),
      borderSide: BorderSide(
        color: focusedBorderColor ?? AppColors.black,
        width: focusedBorderWidth,
      ),
    );

    final double verticalPad =
        ((fieldHeight - fontSize) / 2).clamp(10.0, 28.0).toDouble();

    final menuItems =
        items
            .map(
              (e) => DropdownMenuItem<String>(
                value: e,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    e,
                    textAlign: TextAlign.right,
                    maxLines: menuItemMaxLines,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: fontSize,
                      color: textColor ?? AppColors.black,
                    ),
                  ),
                ),
              ),
            )
            .toList();

    List<Widget> selectedBuilder(BuildContext context) =>
        items
            .map(
              (e) => Align(
                alignment: Alignment.centerRight,
                child: Text(
                  e,
                  textAlign: TextAlign.right,
                  maxLines: selectedMaxLines,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: fontSize,
                    color: textColor ?? AppColors.darkerGrey,
                  ),
                ),
              ),
            )
            .toList();

    final String effectiveValue =
        items.contains(value) ? (value ?? hintText) : hintText;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: DropdownButtonFormField<String>(
        value: effectiveValue,
        isExpanded: true,
        icon: Icon(Icons.arrow_drop_down, color: iconColor ?? AppColors.grey),
        style: TextStyle(
          fontSize: fontSize,
          color: textColor ?? AppColors.black,
        ),
        dropdownColor: dropdownBackgroundColor ?? AppColors.white,
        borderRadius: BorderRadius.circular(borderRadius),
        menuMaxHeight: menuMaxHeight,
        selectedItemBuilder: selectedBuilder,
        decoration: InputDecoration(
          isDense: true,
          filled: true,
          fillColor: (dropdownBackgroundColor ?? AppColors.white).withOpacity(
            0.6,
          ),
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: fontSize,
            color: hintColor ?? AppColors.darkerGrey,
          ),

          constraints: BoxConstraints(minHeight: fieldHeight),
          contentPadding: EdgeInsets.symmetric(
            horizontal: horizontalPadding,
            vertical: verticalPad,
          ),
          border: baseBorder,
          enabledBorder: baseBorder,
          focusedBorder: focusBorder,
        ),
        items: menuItems,
        onChanged: onChanged,
      ),
    );
  }
}
