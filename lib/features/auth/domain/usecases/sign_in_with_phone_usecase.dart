import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/error/failure.dart';
import '../../domain/repositories/auth_repository.dart';

class SignInWithPhoneNumber {
  final AuthRepository authRepository;

  SignInWithPhoneNumber(this.authRepository);

  Future<Either<Failure, void>> call({
    required String phoneNumber,
    required Function(String verificationId, int? resendToken) codeSent,
    required Function(FirebaseAuthException error) verificationFailed,
  }) async {
    return await authRepository.signInWithPhoneNumber(
      phoneNumber,
      codeSent: codeSent,
      verificationFailed: verificationFailed,
    );
  }
}
