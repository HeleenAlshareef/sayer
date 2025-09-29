import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sayer/common/theme/colors.dart';
import 'package:sayer/common/widgets/app_notification.dart';

Future<void> showShowroomEditDialog(
  BuildContext context, {
  required String showroomId,
}) async {
  final doc =
      await FirebaseFirestore.instance
          .collection('ShowroomsOP')
          .doc(showroomId)
          .get();

  final data = doc.data();
  if (data == null) return;

  final nameCtrl = TextEditingController(text: (data['name'] ?? '').toString());
  final phoneCtrl = TextEditingController(
    text: (data['phone'] ?? '').toString(),
  );
  final cityCtrl = TextEditingController(text: (data['city'] ?? '').toString());
  final brandsList =
      (data['brands'] is List) ? List<String>.from(data['brands']) : <String>[];
  final brandsCtrl = TextEditingController(text: brandsList.join(', '));
  final featuredCtrl = TextEditingController(
    text: (data['featuredBrand'] ?? '').toString(),
  );
  final locationCtrl = TextEditingController(
    text: (data['location'] ?? '').toString(),
  );

  const double titleFontSize = 14;
  const double labelFontSize = 12;
  const double hintFontSize = 10;
  const double buttonFontSize = 14;

  final formKey = GlobalKey<FormState>();

  InputDecoration _dec(String label, String hint) => InputDecoration(
    labelText: label,
    labelStyle: TextStyle(
      color: AppColors.darkerGrey,
      fontSize: labelFontSize,
      fontWeight: FontWeight.w500,
    ),
    hintText: hint,
    hintStyle: TextStyle(
      color: AppColors.darkGrey,
      fontSize: hintFontSize,
      fontWeight: FontWeight.w400,
    ),
    filled: true,
    fillColor: AppColors.white,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Colors.black12),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Colors.black12),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppColors.primary, width: 1.6),
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
  );

  showDialog(
    context: context,
    builder: (ctx) {
      return AlertDialog(
        backgroundColor: AppColors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        title: Text(
          'تعديل بيانات المعرض',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.darkerGrey,
            fontWeight: FontWeight.w600,
            fontSize: titleFontSize,
          ),
        ),
        content: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: nameCtrl,
                    decoration: _dec('اسم المعرض', 'أدخل اسم المعرض'),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: phoneCtrl,
                    decoration: _dec('رقم التواصل', '05xxxxxxxx'),
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: cityCtrl,
                    decoration: _dec('المدينة', 'اكتب المدينة'),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: brandsCtrl,
                    decoration: _dec(
                      'العلامات التجارية',
                      'اكتب العلامات مفصولة بفواصل ,',
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: featuredCtrl,
                    decoration: _dec(
                      'العلامة التجارية المميزة',
                      'اكتب الاسم المميز',
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: locationCtrl,
                    decoration: _dec(
                      'الموقع الجغرافي (اختياري)',
                      'رابط أو وصف الموقع',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        actionsPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text(
              'إلغاء',
              style: TextStyle(color: AppColors.black),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              textStyle: const TextStyle(
                fontSize: buttonFontSize,
                fontWeight: FontWeight.w600,
              ),
            ),
            onPressed: () async {
              if (!formKey.currentState!.validate()) return;

              final brandsText = brandsCtrl.text.trim();
              final newBrands =
                  brandsText.isEmpty
                      ? <String>[]
                      : brandsText
                          .split(',')
                          .map((e) => e.trim())
                          .where((e) => e.isNotEmpty)
                          .toList();

              try {
                await FirebaseFirestore.instance
                    .collection('ShowroomsOP')
                    .doc(showroomId)
                    .update({
                      'name': nameCtrl.text.trim(),
                      'phone': phoneCtrl.text.trim(),
                      'city': cityCtrl.text.trim(),
                      'brands': newBrands,
                      'featuredBrand': featuredCtrl.text.trim(),
                      'location': locationCtrl.text.trim(),
                    });

                if (ctx.mounted) {
                  Navigator.of(ctx).pop();
                  context.showNotification(
                    message: "تم التحديث بنجاح",
                    icon: Icons.check_circle_outline,
                    iconColor: Colors.green,
                  );
                }
              } catch (e) {
                if (ctx.mounted) {
                  context.showNotification(
                    message: "فشل التحديث",
                    icon: Icons.error_outline,
                    iconColor: Colors.red,
                  );
                }
              }
            },
            child: const Text('حفظ'),
          ),
        ],
      );
    },
  );
}
