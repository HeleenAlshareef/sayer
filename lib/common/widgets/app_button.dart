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
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: SizedBox(
        width: double.infinity,
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
            ).textTheme.titleSmall!.apply(color: AppColors.white),
          ),
        ),
      ),
    );
  }
}
