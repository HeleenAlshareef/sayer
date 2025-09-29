class Validation {
  static String? validateRequired(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'هذا الحقل مطلوب';
    }
    return null;
  }

  static String? validatePhoneNumber(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'رقم التواصل مطلوب';
    }

    String phone = value.trim();

    if (phone.endsWith('+') && !phone.startsWith('+')) {
      phone = '+' + phone.replaceAll('+', '');
    }

    // يقبل إذا بدأ بـ 05
    if (phone.startsWith('05') && RegExp(r'^[0-9]+$').hasMatch(phone)) {
      return null;
    }

    // يقبل إذا بدأ بـ +966
    if (phone.startsWith('+966') && RegExp(r'^\+966[0-9]+$').hasMatch(phone)) {
      return null;
    }

    // يقبل إذا بدأ بـ 966
    if (phone.startsWith('966') && RegExp(r'^966[0-9]+$').hasMatch(phone)) {
      return null;
    }

    return 'رقم الجوال غير صحيح! يجب أن يبدأ بـ 05 أو +966';
  }

  static bool isDropdownValid(String? value) {
    return value != null && value.trim().isNotEmpty;
  }
}
