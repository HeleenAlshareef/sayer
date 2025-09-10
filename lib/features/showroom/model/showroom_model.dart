class ShowroomModel {
  final String name;
  final String phone;
  final String city;
  final List<String> brands;
  final String featuredBrand;
  final String location;

  ShowroomModel({
    required this.name,
    required this.phone,
    required this.city,
    required this.brands,
    required this.featuredBrand,
    required this.location,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phone': phone,
      'city': city,
      'brands': brands,
      'featuredBrand': featuredBrand,
      'location': location,
      'createdAt': DateTime.now(),
    };
  }

  factory ShowroomModel.fromMap(Map<String, dynamic> map) {
    return ShowroomModel(
      name: map['name'] ?? '',
      phone: map['phone'] ?? '',
      city: map['city'] ?? '',
      brands: List<String>.from(map['brands'] ?? []),
      featuredBrand: map['featuredBrand'] ?? '',
      location: map['location'] ?? '',
    );
  }
}
