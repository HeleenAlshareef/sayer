import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sayer/common/theme/colors.dart';
import 'package:sayer/features/orders/data/firestore_service.dart';
import 'package:sayer/features/orders/ui/widget/filter.dart';
import 'package:sayer/common/widgets/app_bar.dart';
import 'package:sayer/common/helpers/bar.dart';
import 'package:sayer/features/orders/ui/widget/orders_list.dart';
import 'package:sayer/features/orders/models/order_model.dart';
import 'dart:async';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => OrdersScreenState();
}

class OrdersScreenState extends State<OrdersScreen> {
  String? selectedFrom;
  String? selectedStatus;

  List<OrderModel> allOrders = [];
  final FirestoreService firestoreService = FirestoreService();

  StreamSubscription<List<OrderModel>>? ordersSubscription;

  @override
  void initState() {
    super.initState();
    _listenToFilteredOrders();
  }

  void _listenToFilteredOrders() {
    ordersSubscription?.cancel();
    ordersSubscription = firestoreService.listenToOrders().listen((orders) {
      if (!mounted) return;
      setState(() {
        allOrders = orders;
      });
    });
  }

  void onStatusChanged(String? value) {
    setState(() {
      selectedStatus = value;
    });
  }

  void onFromChanged(String? value) {
    setState(() {
      selectedFrom = value;
    });
  }

  @override
  void dispose() {
    ordersSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final fromList = <String?>[
      ...{...allOrders.map((e) => e.formWhere).whereType<String>()},
    ];
    final statusList = <String?>['جديد', 'جارٍ التواصل', 'تم الإغلاق'];

    final filtered =
        allOrders.where((order) {
          final matchesFrom =
              selectedFrom == null || order.formWhere == selectedFrom;
          final matchesStatus =
              selectedStatus == null || order.status == selectedStatus;
          return matchesFrom && matchesStatus;
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
                    statusList: statusList,
                    selectedFrom: selectedFrom,
                    selectedStatus: selectedStatus,
                    onFromChanged: onFromChanged,
                    onStatusChanged: onStatusChanged,
                    borderColor: AppColors.black,
                    focusedBorderColor: AppColors.buttonPrimary,
                    dropdownBackgroundColor: AppColors.white,
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
                    OrdersList(orders: filtered),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
