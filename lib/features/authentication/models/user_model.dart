class UserModel {
  final String name;
  final String email;
  final String phone;
  final String password;

  UserModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    if (json.isNotEmpty) {
      return UserModel(
        name: json['name'],
        email: json['email'],
        phone: json['phone'],
        password: json['password'],
      );
    }
    return UserModel(name: '', email: '', phone: '', password: '');
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'email': email, 'phone': phone, 'password': password};
  }

  @override
  String toString() {
    return 'UserModel(name: $name, email: $email, phone: $phone, password: $password)';
  }
}
