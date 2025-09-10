class ShowroomsListModel {
  final String id;
  final String name;
  final String city;
  final String featuredBrand;
  final String location;
  final String? phone;
  final List<String> availableBrands;

  ShowroomsListModel({
    required this.id,
    required this.name,
    required this.city,
    required this.featuredBrand,
    required this.location,
    this.phone,
    required this.availableBrands,
  });

  factory ShowroomsListModel.fromMap(Map<String, dynamic> data, String docId) {
    return ShowroomsListModel(
      id: docId,
      name: data['name'] ?? '',
      city: data['city'] ?? '',
      featuredBrand: data['featuredBrand'] ?? '',
      location: data['location'] ?? '',
      phone: data['phone'],
      availableBrands: List<String>.from(data['brands'] ?? []),
    );
  }
}
