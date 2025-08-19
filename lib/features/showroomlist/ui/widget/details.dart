class Showroom {
  final String name;
  final String logoPath;
  final String city;
  final String brand;
  final String featuredBrand;
  final String phone;
  final List<String> availableBrands;
  final String location;

  Showroom({
    required this.name,
    required this.logoPath,
    required this.city,
    required this.brand,
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

final List<Showroom> showroomList = [];

/*[
  Showroom(
    name: 'عبد اللطيف جميل',
    logoPath: 'assets/showrooms/5.png',
    city: 'جدة',
    brand: 'تويوتا',
    featuredBrand: 'تويوتا',
    phone: '920002727',
  ),
  Showroom(
    name: 'الناغي',
    logoPath: 'assets/showrooms/3.png',
    city: 'الرياض',
    brand: 'هيونداي',
    featuredBrand: 'هيونداي',
    phone: '920015599',
  ),
  Showroom(
    name: 'الجميح',
    logoPath: 'assets/showrooms/4.png',
    city: 'الدمام',
    brand: 'شفروليه',
    featuredBrand: 'شفروليه',
    phone: '8002442244',
  ),
  Showroom(
    name: 'المجدوعي',
    logoPath: 'assets/showrooms/2.png',
    city: 'الخبر',
    brand: 'شانجان',
    featuredBrand: 'شانجان',
    phone: '920015999',
  ),
];*/
