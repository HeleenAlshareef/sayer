import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sayer/features/orders/models/order_model.dart';

class FirestoreService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final Set<String> notifiedPhones = {};

  Stream<List<OrderModel>> listenToOrders({String? statusFilter}) {
    return firestore.collection('SuggestionCars').snapshots().asyncMap((
      snapshot,
    ) async {
      List<OrderModel> allOrders = [];

      for (var doc in snapshot.docs) {
        final data = doc.data();
        final phone = data['phoneNumber'] ?? doc.id;
        final message = data['Msg'] ?? '';
        final name = data['UserName'] ?? 'اسم غير معروف';
        final from = data['formWhere'] ?? 'مصدر غير معروف';
        final timestamp = (data['timestamp'] as Timestamp?)?.toDate();

        String status = 'جديد';

        try {
          final stateSnap =
              await firestore
                  .collection('OrderStates')
                  .doc(phone)
                  .snapshots()
                  .first;
          if (stateSnap.exists) {
            status = stateSnap.data()?['status'] ?? 'جديد';
          }
        } catch (e) {}

        if (statusFilter == null || status == statusFilter) {
          allOrders.add(
            OrderModel(
              phone: phone,
              message: message,
              name: name,
              formWhere: from,
              status: status,
              timestamp: timestamp,
            ),
          );
        }
      }

      return allOrders;
    });
  }

  Future<void> updateOrderStatus(String phone, String newStatus) async {
    try {
      await firestore.collection('OrderStates').doc(phone).set({
        'status': newStatus,
      }, SetOptions(merge: true));
    } catch (e) {
      print('فشل تحديث الحالة: $e');
    }
  }
}
