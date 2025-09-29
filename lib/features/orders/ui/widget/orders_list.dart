import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sayer/features/orders/ui/widget/order_card.dart';
import 'package:sayer/features/orders/models/order_model.dart';

class OrdersList extends StatelessWidget {
  final List<OrderModel> orders;
  const OrdersList({super.key, required this.orders});

  @override
  Widget build(BuildContext context) {
    final sortedOrders = [...orders]..sort((a, b) {
      final aTime = a.timestamp ?? DateTime.fromMillisecondsSinceEpoch(0);
      final bTime = b.timestamp ?? DateTime.fromMillisecondsSinceEpoch(0);
      return bTime.compareTo(aTime);
    });

    return ListView.separated(
      itemCount: sortedOrders.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      separatorBuilder: (_, __) => SizedBox(height: 12.h),
      itemBuilder: (context, index) {
        return OrderCard(order: sortedOrders[index]);
      },
    );
  }
}
