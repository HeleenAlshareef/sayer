import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sayer/common/theme/colors.dart';

class AppNotification extends StatefulWidget {
  final String message;
  final IconData icon;
  final Color iconColor;
  final VoidCallback onClose;

  const AppNotification({
    Key? key,
    required this.message,
    required this.icon,
    this.iconColor = AppColors.black,
    required this.onClose,
  }) : super(key: key);

  @override
  State<AppNotification> createState() => _AppNotificationState();
}

class _AppNotificationState extends State<AppNotification>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<Offset> slideAnimation;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    slideAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: animationController, curve: Curves.easeOut),
    );

    animationController.forward();

    Timer(const Duration(seconds: 3), () {
      animationController.reverse().then((_) => widget.onClose());
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top + 32.h,
          left: 16.w,
          right: 16.w,
        ),
        child: SlideTransition(
          position: slideAnimation,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.95),
              borderRadius: BorderRadius.circular(30.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(widget.icon, color: widget.iconColor, size: 20.sp),
                SizedBox(width: 12.w),
                Flexible(
                  child: Text(
                    widget.message,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.black,
                      decoration: TextDecoration.none,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(width: 12.w),
                GestureDetector(
                  onTap: widget.onClose,
                  child: Icon(
                    Icons.close,
                    color: Colors.grey[700],
                    size: 20.sp,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Extension
extension AppNotificationExtension on BuildContext {
  void showErrorNotification(String message, {Color? iconColor}) {
    showNotification(
      message: message,
      icon: Icons.error,
      iconColor: iconColor ?? Colors.red,
    );
  }

  void showSuccessNotification(String message, {Color? iconColor}) {
    showNotification(
      message: message,
      icon: Icons.check_circle_outline,
      iconColor: iconColor ?? Colors.green,
    );
  }

  void showNotification({
    required String message,
    required IconData icon,
    Color iconColor = AppColors.black,
  }) {
    final overlay = Overlay.of(this);
    if (overlay == null) return;

    late OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder:
          (_) => AppNotification(
            message: message,
            icon: icon,
            iconColor: iconColor,
            onClose: () => overlayEntry.remove(),
          ),
    );

    overlay.insert(overlayEntry);
  }
}
