import '../entities/auth_entities.dart';
// auth_repository.dart
import 'package:firebase_auth/firebase_auth.dart'; // Import FirebaseAuth

abstract class AuthRepository {
  Future<void> signInWithPhoneNumber(
    String phoneNumber, {
    required Function(String verificationId, int? resendToken) codeSent,
    required Function(FirebaseAuthException e) verificationFailed,
  });
  Future<void> verifyPhoneNumber(String verificationId, String smsCode);
  Stream<Auth?> get currentUser;
}
