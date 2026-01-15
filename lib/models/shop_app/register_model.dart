class RegisterModel {
  int id;
  String username;
  String email;
  String phone;
  String firstName;
  String lastName;

  RegisterModel({
    required this.id,
    required this.username,
    required this.email,
    required this.phone,
    required this.firstName,
    required this.lastName,
  });

  factory RegisterModel.fromJson(Map<String, dynamic> json) {
    return RegisterModel(
      id: json['id'],
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
    );
  }
}
