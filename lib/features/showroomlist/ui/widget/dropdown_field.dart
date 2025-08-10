import 'package:flutter/material.dart';
import 'package:sayer/common/theme/colors.dart';

class AppDropdownField extends StatelessWidget {
  const AppDropdownField({
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

  @override
  Widget build(BuildContext context) {
    final baseBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius),
      borderSide: BorderSide(
        color: borderColor ?? Colors.black26,
        width: borderWidth,
      ),
    );
    final focusBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius),
      borderSide: BorderSide(
        color: focusedBorderColor ?? Colors.black,
        width: focusedBorderWidth,
      ),
    );

    final verticalPad =
        ((fieldHeight - fontSize) / 2).clamp(8.0, 22.0).toDouble();

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
                    style: TextStyle(
                      fontSize: fontSize,
                      color: textColor ?? Colors.black,
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
                  style: TextStyle(
                    fontSize: fontSize,
                    color: textColor ?? AppColors.darkerGrey,
                  ),
                ),
              ),
            )
            .toList();

    return Directionality(
      textDirection: TextDirection.rtl,
      child: DropdownButtonFormField<String>(
        value: value ?? hintText,
        isExpanded: true,
        icon: Icon(Icons.arrow_drop_down, color: iconColor ?? AppColors.grey),
        style: TextStyle(
          fontSize: fontSize,
          color: textColor ?? AppColors.black,
        ),
        dropdownColor: dropdownBackgroundColor ?? Colors.white,
        borderRadius: BorderRadius.circular(borderRadius),
        menuMaxHeight: menuMaxHeight,
        selectedItemBuilder: selectedBuilder,
        decoration: InputDecoration(
          isDense: true,
          filled: true,
          fillColor: (dropdownBackgroundColor ?? Colors.white).withOpacity(0.6),
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: fontSize,
            color: hintColor ?? AppColors.darkerGrey,
          ),
          constraints: BoxConstraints.tightFor(height: fieldHeight),
          contentPadding: EdgeInsets.symmetric(
            horizontal: 12,
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
