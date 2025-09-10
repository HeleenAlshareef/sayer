class Showroom {
  final String name;
  final String logoPath;
  final String city;
  final String featuredBrand;
  final String phone;
  final List<String> availableBrands;
  final String location;

  Showroom({
    required this.name,
    required this.logoPath,
    required this.city,
    required this.featuredBrand,
    required this.phone,
    required this.availableBrands,
    required this.location,
  });

  String get description =>
      'اسم المعرض: $name\n'
      'رقم التواصل: $phone\n'
      'المدينة: $city\n'
      'العلامة التجارية المميزة: $featuredBrand\n'
      'العلامات التجارية المتاحة: ${availableBrands.join(", ")}\n'
      'الموقع الجغرافي: $location';
}
