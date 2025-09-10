import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sayer/common/theme/colors.dart';
import 'package:sayer/features/showroomlist/model/showrooms_list_model.dart';
import 'package:sayer/features/showroomlist/ui/widget/showrooms_menu.dart';

class ShowroomGrid extends StatelessWidget {
  final String? city;
  final String? brand;
  final String? featuredBrand;
  final String? query;
  final Color tileFrameColor;

  const ShowroomGrid({
    super.key,
    this.city,
    this.brand,
    this.featuredBrand,
    this.query,
    this.tileFrameColor = Colors.transparent,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('ShowroomsOP').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final List<ShowroomsListModel> showrooms =
            snapshot.data!.docs
                .map(
                  (doc) => ShowroomsListModel.fromMap(
                    doc.data() as Map<String, dynamic>,
                    doc.id,
                  ),
                )
                .where((s) {
                  final matchesFilters =
                      (city == null || s.city == city) &&
                      (featuredBrand == null ||
                          s.featuredBrand == featuredBrand);

                  final searchTerm = (query ?? '').toLowerCase();
                  final matchesSearch =
                      searchTerm.isEmpty ||
                      s.name.toLowerCase().contains(searchTerm) ||
                      s.city.toLowerCase().contains(searchTerm) ||
                      s.featuredBrand.toLowerCase().contains(searchTerm);

                  return matchesFilters && matchesSearch;
                })
                .toList();

        return GridView.builder(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
          physics: const BouncingScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.82,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemCount: showrooms.length,
          itemBuilder: (context, index) {
            final showroom = showrooms[index];
            return buildTile(context, showroom);
          },
        );
      },
    );
  }

  Widget buildTile(BuildContext context, ShowroomsListModel showroom) {
    return GestureDetector(
      onTap: () => showDetailsDialog(context, showroom),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(6.w),
                  decoration: BoxDecoration(
                    color: tileFrameColor,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(20.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.10),
                          blurRadius: 18,
                          offset: const Offset(0, 8),
                        ),
                        BoxShadow(
                          color: Colors.black.withOpacity(0.03),
                          blurRadius: 36,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Image.asset(
                        'assets/images/NewShowroom.png',
                        width: 80,
                        height: 80,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 6.h),
              Text(
                showroom.name,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.darkerGrey,
                  fontSize: 12.sp,
                ),
              ),
            ],
          ),
          Positioned(
            top: 4,
            right: 4,
            child: ShowroomMenu(showroomId: showroom.id),
          ),
        ],
      ),
    );
  }

  void showDetailsDialog(BuildContext context, ShowroomsListModel showroom) {
    showDialog(
      context: context,
      builder:
          (_) => Directionality(
            textDirection: TextDirection.rtl,
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24.r),
              ),
              backgroundColor: AppColors.white,
              title: Text(
                showroom.name,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: AppColors.darkerGrey,
                  fontSize: 20.sp,
                ),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/images/NewShowroom1.png',
                    width: 60,
                    height: 60,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(height: 16.h),
                  buildInfoRow(context, 'المدينة', showroom.city),
                  buildInfoRow(
                    context,
                    'العلامة المميزة',
                    showroom.featuredBrand,
                  ),
                  buildInfoRow(context, 'الموقع', showroom.location),
                  if ((showroom.phone ?? '').trim().isNotEmpty)
                    buildInfoRow(context, 'رقم التواصل', showroom.phone),
                  buildInfoRow(
                    context,
                    'العلامات المتاحة',
                    showroom.availableBrands.join('، '),
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
    );
  }

  Widget buildInfoRow(BuildContext context, String label, dynamic value) {
    final textValue = (value ?? '').toString().trim();
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: RichText(
        textAlign: TextAlign.right,
        text: TextSpan(
          children: [
            TextSpan(
              text: '$label: ',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.black,
                fontSize: 13.sp,
              ),
            ),
            TextSpan(
              text: textValue.isEmpty ? '-' : textValue,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w400,
                color: AppColors.black,
                fontSize: 12.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
