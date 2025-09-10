import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sayer/features/showroom/model/showroom_model.dart';

class FirestoreShowroomService {
  final CollectionReference _ref = FirebaseFirestore.instance.collection(
    'ShowroomsOP',
  );

  Future<void> addShowroom(ShowroomModel showroom) async {
    await _ref.add(showroom.toMap());
  }

  Future<List<ShowroomModel>> getShowrooms() async {
    final snapshot = await _ref.get();
    return snapshot.docs
        .map((doc) => ShowroomModel.fromMap(doc.data() as Map<String, dynamic>))
        .toList();
  }
}
