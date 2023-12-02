import '../../../../core/error/failure.dart';
import '../entities/auth_entities.dart';
// auth_repository.dart
import 'package:firebase_auth/firebase_auth.dart'; // Import FirebaseAuth
import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  Future<Either<Failure, User?>> signInWithGoogle();
  Future<Either<Failure, void>> signOut();
  Stream<Either<Failure, Auth?>> get currentUser;

  Future<Either<Failure, void>> signInWithPhoneNumber(
    String phoneNumber, {
    required Function(String verificationId, int? resendToken) codeSent,
    required Function(FirebaseAuthException e) verificationFailed,
  });
  Future<Either<Failure, void>> verifyPhoneNumber(
      String verificationId, String smsCode);
}
