import 'package:flutter/material.dart';
import 'package:sayer/common/routing/routes.dart';
import 'package:sayer/common/theme/colors.dart';
import 'package:sayer/common/widgets/app_button.dart';
import 'package:sayer/common/widgets/text_field.dart';
import 'package:sayer/features/showroom/ui/widget/dropdown_field.dart';
import 'package:sayer/features/showroom/ui/widget/multi_select.dart';
import 'package:sayer/common/helpers/extensions.dart';

class ShowroomForm extends StatefulWidget {
  const ShowroomForm({super.key});

  @override
  State<ShowroomForm> createState() => _ShowroomFormState();
}

class _ShowroomFormState extends State<ShowroomForm> {
  String? selectedBrand;
  String? selectedCity;
  List<String> selectedBrands = [];
  List<String> selectedCities = [];

  final FocusNode nameFocus = FocusNode();
  final FocusNode phoneFocus = FocusNode();
  final FocusNode locationFocus = FocusNode();

  @override
  void dispose() {
    nameFocus.dispose();
    phoneFocus.dispose();
    locationFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const double BorderWidth = 1.0;
    const double FocusedBorderWidth = 1.5;
    final Color BorderColor = AppColors.grey;
    final Color FocusedBorderColor = AppColors.black;

    return SingleChildScrollView(
      child: Column(
        children: [
          AppTextField(
            hintText: 'أدخل اسم المعرض',
            labelText: 'اسم المعرض',
            keyboardType: TextInputType.name,
            focusNode: nameFocus,
            textInputAction: TextInputAction.next,
            onFieldSubmitted: (_) {
              FocusScope.of(context).requestFocus(phoneFocus);
            },
          ),

          AppTextField(
            hintText: '05XXXXXXXX',
            labelText: 'رقم التواصل',
            keyboardType: TextInputType.phone,
            focusNode: phoneFocus,
            textInputAction: TextInputAction.next,
            onFieldSubmitted: (_) {
              FocusScope.of(context).requestFocus(locationFocus);
            },
          ),

          AppDropdownField(
            hintText: 'اختر المدينة',
            items: const [
              'الرياض',
              'مكة المكرمة',
              'المدينة المنورة',
              'القصيم',
              'الشرقية',
              'عسير',
              'تبوك',
              'حائل',
              'الباحة',
              'الجوف',
              'نجران',
              'جازان',
              'الحدود الشمالية',
            ],
            value: selectedCity,
            onChanged: (val) {
              setState(() {
                selectedCity = val;
              });
            },
            borderColor: BorderColor,
            focusedBorderColor: FocusedBorderColor,
            borderWidth: BorderWidth,
            focusedBorderWidth: FocusedBorderWidth,
          ),

          MultiSelect(
            hintText: 'اختر العلامات التجارية المتاحة',
            items: const [
              'MG',
              'Jeep',
              'Jetour',
              'Chery',
              'Geely',
              'Saic motor',
              'GAC',
              'Dongfeng',
              'Chevrolet',
              'RENAUTL',
              'Bestune',
              'Mitsubishi',
              'Land Rover',
              'Ford',
              'Dodge',
              'Genesis',
              'Chrysler',
              'GMC',
              'Honda',
              'Mazda',
              'Changan',
              'Lexus',
              'Haval',
              'Kia',
            ],
            selectedValues: selectedBrands,
            onConfirm: (values) {
              setState(() {
                selectedBrands = values;
              });
            },
          ),

          AppDropdownField(
            hintText: 'اختر العلامة التجارية المميزة',
            items: const [
              'MG',
              'Jeep',
              'Jetour',
              'Chery',
              'Geely',
              'Saic motor',
              'GAC',
              'Dongfeng',
              'Chevrolet',
              'RENAUTL',
              'Bestune',
              'Mitsubishi',
              'Land Rover',
              'Ford',
              'Dodge',
              'Genesis',
              'Chrysler',
              'GMC',
              'Honda',
              'Mazda',
              'Changan',
              'Lexus',
              'Haval',
              'Kia',
            ],
            value: selectedBrand,
            onChanged: (val) {
              setState(() {
                selectedBrand = val;
              });
            },
            borderColor: BorderColor,
            focusedBorderColor: FocusedBorderColor,
            borderWidth: BorderWidth,
            focusedBorderWidth: FocusedBorderWidth,
          ),

          AppTextField(
            hintText: 'أدخل رابط الموقع الجغرافي',
            labelText: 'الموقع الجغرافي',
            keyboardType: TextInputType.text,
            focusNode: locationFocus,
            textInputAction: TextInputAction.done,
            onFieldSubmitted: (_) {
              locationFocus.unfocus();
            },
          ),

          AppButton(
            title: "إضافة",
            onPressed: () {
              context.pushNamed(Routes.showroomList);
            },
          ),
        ],
      ),
    );
  }
}
