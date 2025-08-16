import 'package:flutter/material.dart';
import 'package:sayer/common/theme/colors.dart';

class ShowroomSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  const ShowroomSearchBar({
    super.key,
    required this.controller,
    required this.onChanged,
    required FocusNode focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: 'اسم المعرض',
        hintStyle: TextStyle(color: AppColors.darkerGrey, fontSize: 14),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),

        suffixIcon: Icon(Icons.search, color: AppColors.darkerGrey),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.darkerGrey, width: 0.7),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.darkerGrey, width: 0.7),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.darkerGrey, width: 1),
        ),
        filled: false,
      ),
    );
  }
}
