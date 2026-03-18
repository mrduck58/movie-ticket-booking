class RegisterRequestModel {
  final String email;
  final String password;
  final String phone;
  final String fullName;
  final String dateOfBirth;
  final List<String> favoriteGenres;

  RegisterRequestModel({
    required this.email,
    required this.password,
    required this.phone,
    required this.fullName,
    required this.dateOfBirth,
    required this.favoriteGenres,
  });

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
        "phone": phone,
        "fullName": fullName,
        "dateOfBirth": dateOfBirth,
        "favoriteGenres": favoriteGenres,
      };
}