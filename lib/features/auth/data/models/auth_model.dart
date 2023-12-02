import 'package:leee3/features/auth/domain/entities/auth_entities.dart';

class AuthModel extends Auth {
  const AuthModel({
    required super.id,
    required super.name,
    required super.email,
    required super.phoneNumber,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'email': email, 'phoneNumber': phoneNumber};
  }
}
