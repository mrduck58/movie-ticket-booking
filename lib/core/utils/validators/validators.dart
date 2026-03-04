class Validators {
  static String? required(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Trường này không được để trống';
    }
    return null;
  }

  static String? email(String? value) {
    if (value == null || value.isEmpty) return null;
    final regex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!regex.hasMatch(value)) {
      return 'Email không hợp lệ';
    }
    return null;
  }
}