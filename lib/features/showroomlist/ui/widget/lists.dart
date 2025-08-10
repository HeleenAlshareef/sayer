import 'package:flutter/material.dart';
import 'package:sayer/common/theme/colors.dart';
import 'details.dart'; // تأكد من المسار الصحيح

class ShowroomGrid extends StatelessWidget {
  final String? city;
  final String? brand;
  final String? featuredBrand;
  final String? query;

  const ShowroomGrid({
    super.key,
    this.city,
    this.brand,
    this.featuredBrand,
    this.query,
  });

  @override
  Widget build(BuildContext context) {
    final q = (query ?? '').trim();

    final filtered =
        showroomList.where((s) {
          final byCity = city == null || s.city == city;
          final byBrand = brand == null || s.brand == brand;
          final byFeatured =
              featuredBrand == null || s.featuredBrand == featuredBrand;
          final byQuery =
              q.isEmpty ||
              s.name.contains(q) ||
              s.city.contains(q) ||
              s.brand.contains(q) ||
              s.featuredBrand.contains(q);

          return byCity && byBrand && byFeatured && byQuery;
        }).toList();

    return GridView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: filtered.length,
      itemBuilder: (context, index) {
        final showroom = filtered[index];
        return GestureDetector(
          onTap:
              () => showDialog(
                context: context,
                builder:
                    (_) => AlertDialog(
                      title: Text(showroom.name, textAlign: TextAlign.center),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(showroom.logoPath, height: 100),
                          const SizedBox(height: 20),
                          Text(
                            showroom.description,
                            textAlign: TextAlign.right,
                          ),
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: Text(
                            'إغلاق',
                            style: TextStyle(color: AppColors.primary),
                          ),
                        ),
                      ],
                    ),
              ),
          child: Card(
            color: AppColors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Image.asset(showroom.logoPath),
            ),
          ),
        );
      },
    );
  }
}
