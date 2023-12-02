import 'package:equatable/equatable.dart';

import 'package:firebase_auth/firebase_auth.dart';

class Auth extends Equatable {
  final String id;
  final String name;

  final String phoneNumber;
  final String email;

  const Auth({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
  });

  factory Auth.fromFirebaseUser(User user) {
    return Auth(
      id: user.uid,
      name: user.displayName ?? '',
      email: user.email ?? '',
      phoneNumber: user.phoneNumber ?? '',
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        email,
        phoneNumber,
      ];
}
