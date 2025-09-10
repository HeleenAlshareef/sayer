import 'package:sayer/features/showroom/model/firestore_showroom.dart';
import 'package:sayer/features/showroom/model/showroom_model.dart';

class ShowroomController {
  final FirestoreShowroomService service = FirestoreShowroomService();

  Future<void> saveShowroom({
    required String name,
    required String phone,
    required String city,
    required List<String> brands,
    required String featuredBrand,
    required String location,
  }) async {
    final model = ShowroomModel(
      name: name,
      phone: phone,
      city: city,
      brands: brands,
      featuredBrand: featuredBrand,
      location: location,
    );

    await service.addShowroom(model);
  }
}
