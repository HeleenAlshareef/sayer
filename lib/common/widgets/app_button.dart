import 'package:flutter/material.dart';
import 'package:sayer/common/theme/colors.dart';

class AppButton extends StatelessWidget {
  final String title;
  final TextEditingController? phoneController;
  final VoidCallback? onPressed;

  const AppButton({
    super.key,
    required this.title,
    this.phoneController,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 340,
      height: 60,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF112D4E),
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: Text(
          title,
          style: Theme.of(
            context,
          ).textTheme.titleSmall?.copyWith(color: AppColors.white),
        ),
      ),
    );
  }
}
