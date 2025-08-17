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

  const AppTextField({
    Key? key,
    required this.hintText,
    this.labelText,
    this.keyboardType = TextInputType.text,
    this.controller,
    this.obscureText = false,
    this.focusNode,
    this.onFieldSubmitted,
    required TextInputAction textInputAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          style: TextStyle(fontSize: 12.sp, color: AppColors.darkerGrey),
          decoration: InputDecoration(
            labelText: labelText,
            hintText: hintText,
            contentPadding: EdgeInsets.all(16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(color: AppColors.black),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(color: AppColors.darkerGrey),
            ),
          ),
        ),
      ),
    );
  }
}
