import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sayer/common/theme/colors.dart';
import 'package:sayer/features/orders/data/firestore_service.dart';
import 'package:sayer/features/orders/ui/widget/status_dropdown.dart';

class StatusPopup {
  static void show({
    required BuildContext context,
    required String phone,
    required String currentStatus,
    required Function(String) onStatusUpdated,
  }) {
    final firestoreService = FirestoreService();

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
          backgroundColor: AppColors.white,
          child: SizedBox(
            width: 200.w,
            child: Padding(
              padding: EdgeInsets.all(20.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'تحديث الحالة',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.black,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Divider(color: AppColors.lightGrey, thickness: 1),
                  SizedBox(height: 16.h),
                  StatusDropdown(
                    phone: phone,
                    currentStatus: currentStatus,
                    onChanged: (newStatus) async {
                      Navigator.pop(context);
                      if (newStatus != currentStatus) {
                        await firestoreService.updateOrderStatus(
                          phone,
                          newStatus,
                        );
                        onStatusUpdated(newStatus);
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
