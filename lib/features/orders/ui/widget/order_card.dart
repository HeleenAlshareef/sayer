import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sayer/common/theme/colors.dart';
import 'package:sayer/features/orders/models/order_model.dart';
import 'package:sayer/features/orders/ui/widget/orders_time.dart';
import 'package:sayer/features/orders/ui/widget/status_popup.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderCard extends StatefulWidget {
  final OrderModel order;

  const OrderCard({super.key, required this.order});

  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  @override
  Widget build(BuildContext context) {
    final phone = widget.order.phone;
    final name = widget.order.name;
    final message = widget.order.message;
    final timestamp = widget.order.timestamp;
    final currentStatus = widget.order.status;

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
          Row(
            textDirection: TextDirection.rtl,
            children: [
              Expanded(
                child: Text(
                  name,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  StatusPopup.show(
                    context: context,
                    phone: phone,
                    currentStatus: currentStatus,
                    onStatusUpdated: (newStatus) {
                      setState(() {
                        widget.order.status = newStatus;
                      });
                    },
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    color: getStatusColor(currentStatus).withOpacity(0.08),
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(color: getStatusColor(currentStatus)),
                  ),
                  child: Text(
                    currentStatus,
                    style: TextStyle(
                      color: getStatusColor(currentStatus),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              IconButton(
                onPressed: phone.isNotEmpty ? () => openWhatsApp(phone) : null,
                icon: const FaIcon(
                  FontAwesomeIcons.whatsapp,
                  size: 18,
                  color: Colors.green,
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            child: const Divider(
              height: 1,
              thickness: 1,
              color: Colors.black12,
            ),
          ),
          info(context, 'رقم التواصل', phone),
          Row(
            textDirection: TextDirection.rtl,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: info(context, 'الطلب', message)),
              SizedBox(width: 8.w),
              OrderTime(timestamp: timestamp),
            ],
          ),
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
            color: AppColors.black,
            fontSize: 10.sp,
          ),
          children: [
            TextSpan(
              text: '$label: ',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.black,
                fontSize: 12.sp,
              ),
            ),
            TextSpan(text: (value == null || value.isEmpty) ? '-' : value),
          ],
        ),
      ),
    );
  }

  void openWhatsApp(String phone) async {
    final cleanedPhone = phone.replaceAll(RegExp(r'\D'), '');
    final formattedPhone =
        cleanedPhone.startsWith('966') ? cleanedPhone : '966$cleanedPhone';
    final uri = Uri.parse('https://wa.me/$formattedPhone');

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  Color getStatusColor(String status) {
    switch (status) {
      case 'جديد':
        return Colors.green;
      case 'جارٍ التواصل':
        return const Color.fromARGB(255, 213, 179, 27);
      case 'تم الإغلاق':
        return const Color.fromARGB(255, 193, 30, 30);
      default:
        return AppColors.black;
    }
  }
}
