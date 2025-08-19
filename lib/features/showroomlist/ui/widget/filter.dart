import 'package:flutter/material.dart';
import 'package:sayer/common/theme/colors.dart';
import 'package:sayer/features/showroomlist/ui/widget/dropdown_field.dart';

Future<void> showFiltersSheet({
  required BuildContext context,
  required List<String> cities,
  required List<String> brands,
  List<String>? featuredBrands,
  String? selectedCity,
  String? selectedBrand,
  String? selectedFeaturedBrand,
  required ValueChanged<String?> onCityChanged,
  required ValueChanged<String?> onBrandChanged,
  required ValueChanged<String?> onFeaturedBrandChanged,
}) async {
  String? tmpCity = selectedCity;
  String? tmpBrand = selectedBrand;
  String? tmpFeatured = selectedFeaturedBrand;

  final cityItems = ['الكل', ...cities];
  final brandItems = ['الكل', ...brands];
  final featuredItems = ['الكل', ...((featuredBrands ?? brands))];

  await showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (ctx) {
      return Directionality(
        textDirection: TextDirection.rtl,
        child: SafeArea(
          top: false,
          child: Padding(
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              top: 12,
              bottom: MediaQuery.of(ctx).viewInsets.bottom + 24,
            ),
            child: StatefulBuilder(
              builder: (context, setState) {
                const double sideShrink = 12;

                Widget buildDropdown({
                  required String label,
                  required List<String> items,
                  required String? value,
                  required ValueChanged<String?> setTmp,
                }) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        label,
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 6),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: sideShrink,
                        ),
                        child: ShowroomListDropdownField(
                          items: items,
                          value: value ?? 'الكل',
                          onChanged:
                              (v) => setState(
                                () => setTmp(v == 'الكل' ? null : v),
                              ),
                          fieldHeight: 56,
                          fontSize: 15,
                          borderRadius: 12,
                          borderColor: AppColors.darkGrey,
                          focusedBorderColor: AppColors.primary,
                          dropdownBackgroundColor: AppColors.white,
                          hintColor: AppColors.darkerGrey,
                          textColor: AppColors.darkerGrey,
                          iconColor: AppColors.darkGrey,
                        ),
                      ),
                    ],
                  );
                }

                final elevatedStyle = ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 14,
                  ),
                  minimumSize: const Size(120, 46),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ).copyWith(
                  overlayColor: WidgetStatePropertyAll(
                    AppColors.primary.withOpacity(0.12),
                  ),
                );

                final outlinedStyle = OutlinedButton.styleFrom(
                  foregroundColor: AppColors.primary,
                  side: BorderSide(color: AppColors.primary, width: 1.2),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 14,
                  ),
                  minimumSize: const Size(110, 46),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  backgroundColor: AppColors.white,
                ).copyWith(
                  overlayColor: WidgetStatePropertyAll(
                    AppColors.primary.withOpacity(0.08),
                  ),
                );

                return SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 40,
                        height: 4,
                        margin: const EdgeInsets.only(bottom: 12),
                        decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.circular(999),
                        ),
                      ),
                      const Text(
                        'تصفية النتائج',
                        style: TextStyle(fontWeight: FontWeight.w800),
                      ),
                      const SizedBox(height: 16),

                      buildDropdown(
                        label: 'المدينة',
                        items: cityItems,
                        value: tmpCity ?? 'الكل',
                        setTmp: (v) => tmpCity = v,
                      ),
                      const SizedBox(height: 12),

                      buildDropdown(
                        label: 'العلامة التجارية',
                        items: brandItems,
                        value: tmpBrand ?? 'الكل',
                        setTmp: (v) => tmpBrand = v,
                      ),
                      const SizedBox(height: 12),

                      buildDropdown(
                        label: 'العلامة المميزة',
                        items: featuredItems,
                        value: tmpFeatured ?? 'الكل',
                        setTmp: (v) => tmpFeatured = v,
                      ),

                      const SizedBox(height: 20),

                      Row(
                        children: [
                          OutlinedButton(
                            style: outlinedStyle,
                            onPressed: () {
                              setState(() {
                                tmpCity = null;
                                tmpBrand = null;
                                tmpFeatured = null;
                              });
                            },
                            child: const Text(
                              'مسح',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                          const Spacer(),
                          ElevatedButton(
                            style: elevatedStyle,
                            onPressed: () {
                              onCityChanged(tmpCity);
                              onBrandChanged(tmpBrand);
                              onFeaturedBrandChanged(tmpFeatured);
                              Navigator.pop(context);
                            },
                            child: const Text(
                              'تطبيق',
                              style: TextStyle(fontWeight: FontWeight.w700),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      );
    },
  );
}
