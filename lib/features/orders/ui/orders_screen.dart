import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sayer/common/theme/colors.dart';
import 'package:sayer/features/orders/ui/widget/orders_data.dart';
import 'package:sayer/features/orders/ui/widget/orders_list.dart';
import 'package:sayer/features/orders/ui/widget/filter.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  String? selectedCity;
  String? selectedStatus;

  @override
  Widget build(BuildContext context) {
    final List<String?> cities = [null];
    cities.addAll(ordersData.map((e) => e['city']).whereType<String>().toSet());

    final List<String?> statuses = [null, 'جديد', 'جار التواصل', 'تم الإغلاق'];

    final filtered =
        ordersData.where((o) {
          final okCity = selectedCity == null || o['city'] == selectedCity;
          final okStatus =
              selectedStatus == null || o['status'] == selectedStatus;
          return okCity && okStatus;
        }).toList();

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: const Alignment(0.0, -0.2),
          colors: [AppColors.gradientStart, AppColors.gradientend],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: AppColors.darkerGrey,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
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
                    SizedBox(width: 48.w), // موازنة للعنوان
                  ],
                ),

                SizedBox(height: 20.h),

                // الفلاتر
                FilterWidget(
                  cities: cities,
                  statuses: statuses,
                  selectedCity: selectedCity,
                  selectedStatus: selectedStatus,
                  onCityChanged:
                      (v) => setState(
                        () =>
                            selectedCity =
                                (v == null || v == 'الكل') ? null : v,
                      ),
                  onStatusChanged:
                      (v) => setState(
                        () =>
                            selectedStatus =
                                (v == null || v == 'الكل') ? null : v,
                      ),
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
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.darkGrey,
                        ),
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
    );
  }
}
