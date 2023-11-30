import 'package:leee3/features/auth/domain/entities/auth_entities.dart';

class AuthModel extends Auth {
  AuthModel({
    required String id,
    required String phoneNumber,
    required String name,
  }) : super(id: id, phoneNumber: phoneNumber, name: name);

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      id: json['id'],
      phoneNumber: json['phoneNumber'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'phoneNumber': phoneNumber,
      'name': name,
    };
  }
}
