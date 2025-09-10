import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:home_widget/home_widget.dart';

Future<void> fetchAndSendOrderStats() async {
  await HomeWidget.setAppGroupId('group.SayerWidget');

  // Fetch order data from Firestore
  final orderStatesRef = FirebaseFirestore.instance.collection('OrderStates');

  final totalSnapshot = await orderStatesRef.get();
  int totalOrders = totalSnapshot.docs.length;

  final newSnapshot =
      await orderStatesRef.where('status', isEqualTo: 'جديد').get();
  final inProgressSnapshot =
      await orderStatesRef.where('status', isEqualTo: 'جارٍ التواصل').get();
  final closedSnapshot =
      await orderStatesRef.where('status', isEqualTo: 'تم الإغلاق').get();

  // Save the values to be used in the widget
  await HomeWidget.saveWidgetData<int>('total_orders', totalOrders);
  await HomeWidget.saveWidgetData<int>('new_orders', newSnapshot.docs.length);
  await HomeWidget.saveWidgetData<int>(
    'in_progress_orders',
    inProgressSnapshot.docs.length,
  );
  await HomeWidget.saveWidgetData<int>(
    'closed_orders',
    closedSnapshot.docs.length,
  );

  // Trigger widget update
  await HomeWidget.updateWidget(name: 'SayerWidget', iOSName: 'SayerWidget');
}
