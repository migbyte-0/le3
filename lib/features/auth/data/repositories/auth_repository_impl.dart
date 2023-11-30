import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/entities/auth_entities.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<void> signInWithPhoneNumber(
    String phoneNumber, {
    required Function(String verificationId, int? resendToken) codeSent,
    required Function(FirebaseAuthException e) verificationFailed,
  }) {
    // Pass the additional parameters to the remote data source.
    return remoteDataSource.signInWithPhoneNumber(
      phoneNumber,
      codeSent: codeSent,
      verificationFailed: verificationFailed,
    );
  }

  @override
  Future<void> verifyPhoneNumber(String verificationId, String smsCode) {
    return remoteDataSource.verifyPhoneNumber(
      verificationId,
    );
  }

  @override
  Stream<Auth?> get currentUser {
    return remoteDataSource.currentUser;
  }
}
