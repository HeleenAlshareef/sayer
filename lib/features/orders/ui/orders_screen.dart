import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sayer/common/helpers/notification.dart';
import 'package:sayer/common/theme/colors.dart';
import 'package:sayer/features/orders/data/firestore_service.dart';
import 'package:sayer/features/orders/ui/widget/filter.dart';
import 'package:sayer/common/widgets/app_bar.dart';
import 'package:sayer/common/helpers/bar.dart';
import 'package:sayer/features/orders/ui/widget/orders_list.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => OrdersScreenState();
}

class OrdersScreenState extends State<OrdersScreen> {
  String? selectedFrom;
  List<Map<String, dynamic>> allOrders = [];
  final FirestoreService firestoreService = FirestoreService();

  @override
  void initState() {
    super.initState();
    NotificationHelper.initialize();
    listenToOrdersStream();
  }

  void listenToOrdersStream() {
    firestoreService.listenToOrders().listen((orders) {
      final data =
          orders.map((order) {
            return {
              'name': order.name,
              'phone': order.phone,
              'message': order.message,
              'from': order.formWhere,
            };
          }).toList();

      if (data.length > allOrders.length) {
        NotificationHelper.showNotification(
          'طلب جديد',
          'تم استلام طلب جديد من ${data.last['name']}',
        );
      }

      setState(() {
        allOrders = data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final fromList = <String?>[
      null,
      ...{...allOrders.map((e) => e['from']).whereType<String>()},
    ];

    final filtered =
        allOrders.where((o) {
          final fromMatches = selectedFrom == null || o['from'] == selectedFrom;
          return fromMatches;
        }).toList();

    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            'assets/images/otpBackground.PNG',
            fit: BoxFit.cover,
            alignment: Alignment.topCenter,
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          bottomNavigationBar: AppBottomNav(
            currentIndex: 2,
            onTap: (i) => handleBottomTap(context, 2, i),
          ),
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  Row(
                    children: [
                      SizedBox(width: 48.w),
                      Expanded(
                        child: Text(
                          'الطلبات',
                          textAlign: TextAlign.center,
                          style: Theme.of(
                            context,
                          ).textTheme.titleMedium?.copyWith(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w800,
                            color: AppColors.darkerGrey,
                          ),
                        ),
                      ),
                      SizedBox(width: 48.w),
                    ],
                  ),
                  SizedBox(height: 20.h),

                  FilterWidget(
                    fromList: fromList,
                    selectedFrom: selectedFrom,
                    onFromChanged: (v) => setState(() => selectedFrom = v),
                    borderColor: Colors.black26,
                    focusedBorderColor: AppColors.buttonPrimary,
                    dropdownBackgroundColor: Colors.white,
                    hintColor: AppColors.darkerGrey,
                    textColor: AppColors.black,
                  ),

                  SizedBox(height: 16.h),

                  if (filtered.isEmpty)
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 40.h),
                      child: Center(
                        child: Text(
                          'لا توجد نتائج مطابقة',
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(color: AppColors.darkGrey),
                        ),
                      ),
                    )
                  else
                    OrdersList(
                      orders:
                          filtered
                              .map(
                                (e) =>
                                    e.map((k, v) => MapEntry(k, v.toString())),
                              )
                              .toList(),
                    ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
