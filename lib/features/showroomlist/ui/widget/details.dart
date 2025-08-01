class Showroom {
  final String name;
  final String logoPath;
  final String description;

  Showroom({
    required this.name,
    required this.logoPath,
    required this.description,
  });
}

final List<Showroom> showroomList = [
  Showroom(
    name: 'CHERY',
    logoPath: 'assets/showrooms/chery.PNG',
    description: 'شركة شيري',
  ),
  Showroom(
    name: 'Jeep',
    logoPath: 'assets/showrooms/jeep.PNG',
    description: 'شركة جيب',
  ),
  Showroom(
    name: 'HYUNDAI',
    logoPath: 'assets/showrooms/hyundai.PNG',
    description: 'شركة هونداي',
  ),
  Showroom(
    name: 'CHEVROLET',
    logoPath: 'assets/showrooms/chevrolet.PNG',
    description: 'شركة شفروليه',
  ),
  Showroom(
    name: 'KIA',
    logoPath: 'assets/showrooms/kia.PNG',
    description: 'شركة كيا',
  ),
  Showroom(
    name: 'MGC',
    logoPath: 'assets/showrooms/gmc.PNG',
    description: 'شركة جي ام سي',
  ),
  Showroom(
    name: 'FORD',
    logoPath: 'assets/showrooms/ford.PNG',
    description: 'شركة فورد',
  ),
  Showroom(
    name: 'LEXUS',
    logoPath: 'assets/showrooms/lexus.PNG',
    description: 'شركة ليكزس',
  ),
  Showroom(
    name: 'TOYOTA',
    logoPath: 'assets/showrooms/toyota.PNG',
    description: 'شركة تيوتا',
  ),
];
