import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sayer/common/theme/colors.dart';

class AppTextField extends StatelessWidget {
  final String hintText;
  final String? labelText;
  final TextInputType keyboardType;
  final TextEditingController? controller;
  final bool obscureText;
  final FocusNode? focusNode;
  final void Function(String)? onFieldSubmitted;
  final TextInputAction textInputAction;

  final Color? labelColor;
  final Color? focusedLabelColor;
  final Color? textColor;
  final Color? hintColor;
  final Color? borderColor;
  final Color? focusedBorderColor;
  final Color? fillColor;

  final String? Function(String?)? validator;

  const AppTextField({
    super.key,
    required this.hintText,
    this.labelText,
    this.keyboardType = TextInputType.text,
    this.controller,
    this.obscureText = false,
    this.focusNode,
    this.onFieldSubmitted,
    required this.textInputAction,
    this.labelColor,
    this.focusedLabelColor,
    this.textColor,
    this.hintColor,
    this.borderColor,
    this.focusedBorderColor,
    this.fillColor,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final Color effectiveTextColor = textColor ?? AppColors.darkerGrey;
    final Color effectiveLabelColor = labelColor ?? AppColors.black;
    final Color effectiveFocusedLabelColor =
        focusedLabelColor ?? AppColors.black;
    final Color effectiveHintColor = hintColor ?? AppColors.darkerGrey;
    final Color effectiveBorderColor = borderColor ?? AppColors.grey;
    final Color effectiveFocusedBorderColor =
        focusedBorderColor ?? AppColors.black;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 6),
      child: SizedBox(
        width: double.infinity,
        height: 60,
        child: TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscureText,
          focusNode: focusNode,
          onFieldSubmitted: onFieldSubmitted,
          textInputAction: textInputAction,
          validator: validator,
          style: TextStyle(
            fontSize: 12.sp,
            color: effectiveTextColor,
            fontFamily: Theme.of(context).textTheme.bodyMedium?.fontFamily,
          ),
          decoration: InputDecoration(
            label:
                labelText != null
                    ? RichText(
                      text: TextSpan(
                        text: labelText!.replaceAll('*', ''),
                        style: TextStyle(
                          color: effectiveLabelColor,
                          fontSize: 12.sp,
                          fontFamily:
                              Theme.of(
                                context,
                              ).textTheme.bodyMedium?.fontFamily,
                        ),
                        children:
                            labelText!.contains('*')
                                ? [
                                  TextSpan(
                                    text: ' *',
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 14.sp,
                                      fontFamily:
                                          Theme.of(
                                            context,
                                          ).textTheme.bodyMedium?.fontFamily,
                                    ),
                                  ),
                                ]
                                : [],
                      ),
                    )
                    : null,
            floatingLabelStyle: TextStyle(
              color: effectiveFocusedLabelColor,
              fontSize: 10.sp,
              fontFamily: Theme.of(context).textTheme.bodyMedium?.fontFamily,
            ),
            hintText: hintText,
            hintStyle: TextStyle(fontSize: 10.sp, color: effectiveHintColor),
            contentPadding: EdgeInsets.all(16),
            filled: fillColor != null,
            fillColor: fillColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(color: effectiveBorderColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(color: effectiveBorderColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(color: effectiveFocusedBorderColor),
            ),
          ),
        ),
      ),
    );
  }
}
