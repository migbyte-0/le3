import 'package:firebase_auth/firebase_auth.dart';
import '../repositories/auth_repository.dart';

class SignInWithPhone {
  final AuthRepository repository;

  SignInWithPhone(this.repository);

  Future<void> execute(
    String phoneNumber, {
    required Function(String verificationId, int? resendToken) codeSent,
    required Function(FirebaseAuthException e) verificationFailed,
  }) async {
    return repository.signInWithPhoneNumber(
      phoneNumber,
      codeSent: codeSent,
      verificationFailed: verificationFailed,
    );
  }
}
