class Validation {
  static String? validateRequired(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'هذا الحقل مطلوب';
    }
    return null;
  }

  static String? validatePhoneNumber(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'رقم الجوال مطلوب';
    }
    if (value.length != 10) {
      return 'رقم الجوال يجب أن يتكون من 10 خانات';
    }
    if (!value.startsWith('05')) {
      return 'رقم الجوال غير صحيح! يجب أن يبدأ بـ 05';
    }
    final numericRegex = RegExp(r'^[0-9]+$');
    if (!numericRegex.hasMatch(value)) {
      return 'رقم الجوال يجب أن يحتوي على أرقام فقط';
    }
    return null;
  }

  static bool isDropdownValid(String? value) {
    return value != null && value.trim().isNotEmpty;
  }
}
