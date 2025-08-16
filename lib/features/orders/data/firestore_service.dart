import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sayer/common/helpers/notification.dart';
import 'package:sayer/features/orders/models/order_model.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<OrderModel>> listenToOrders() {
    return _firestore.collection('SuggestionCars').snapshots().asyncMap((
      snapshot,
    ) async {
      List<OrderModel> allOrders = [];

      for (var doc in snapshot.docs) {
        final data = doc.data();
        final phone = data['phoneNumber'] ?? doc.id;
        final message = data['Msg'] ?? '';
        final name = data['UserName'] ?? 'اسم غير معروف';
        final from = data['formWhere'] ?? 'مصدر غير معروف';

        allOrders.add(
          OrderModel(
            phone: phone,
            message: message,
            name: name,
            formWhere: from,
          ),
        );

        NotificationHelper.showNotification(
          "طلب جديد من $name",
          message.isNotEmpty ? message : "بدون رسالة",
        );
      }

      return allOrders;
    });
  }
}
