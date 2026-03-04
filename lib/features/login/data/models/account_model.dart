class Accountmodel {
  final String email;
  final String password;
  Accountmodel({
    required this.email,
    required this.password,
  });
  factory Accountmodel.fromJson(Map<String, dynamic> json) {
    return Accountmodel(
      email: json['email'],
      password: json['password'],
    );
  }
}