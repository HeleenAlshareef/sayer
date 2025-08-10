import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sayer/common/theme/colors.dart';

class OrdersList extends StatelessWidget {
  final List<Map<String, String>> orders;
  const OrdersList({super.key, required this.orders});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: orders.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      separatorBuilder: (_, __) => SizedBox(height: 12.h),
      itemBuilder: (context, index) {
        final order = orders[index];
        return OrderCard(order: order);
      },
    );
  }
}

class OrderCard extends StatelessWidget {
  final Map<String, String> order;
  const OrderCard({required this.order});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14.r),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.08),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // الاسم
          Text(
            order['name'] ?? '',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.primary,
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            child: const Divider(
              height: 1,
              thickness: 1,
              color: Colors.black12,
            ),
          ),

          info(context, 'رقم التواصل', order['phone']),
          info(context, 'المعرض', order['showroom']),
          info(context, 'البراند', order['brand']),
          info(context, 'المدينة', order['city']),
          info(context, 'الحالة', order['status']),
        ],
      ),
    );
  }

  Widget info(BuildContext context, String label, String? value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 4.h),
      child: RichText(
        textAlign: TextAlign.right,
        text: TextSpan(
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Colors.black87,
            fontSize: 10.sp,
          ),
          children: [
            TextSpan(
              text: '$label: ',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: Colors.black87,
                fontSize: 12.sp,
              ),
            ),
            TextSpan(text: value ?? '-'),
          ],
        ),
      ),
    );
  }
}
