import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sayer/common/theme/colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

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
  final double iconSize;
  final Color iconColor;

  const OrderCard({
    super.key,
    required this.order,
    this.iconSize = 18,
    this.iconColor = Colors.green,
  });

  @override
  Widget build(BuildContext context) {
    final phone = order['phone'] ?? '';
    final name = order['name'] ?? 'اسم غير معروف';

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
              IconButton(
                onPressed: phone.isNotEmpty ? () => openWhatsApp(phone) : null,
                icon: FaIcon(
                  FontAwesomeIcons.whatsapp,
                  size: iconSize,
                  color: iconColor,
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
          info(context, 'الطلب', order['message']),
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
            TextSpan(text: value ?? '-'),
          ],
        ),
      ),
    );
  }
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
