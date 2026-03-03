extension StringX on String {
  bool get isEmail =>
      RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(this);

  bool get isPhone =>
      RegExp(r'^[0-9]{9,11}$').hasMatch(this);
}s