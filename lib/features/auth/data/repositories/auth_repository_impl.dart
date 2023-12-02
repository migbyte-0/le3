import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entities/auth_entities.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepositoryImpl(this.authRemoteDataSource);

  @override
  Future<Either<Failure, User?>> signInWithGoogle() async {
    try {
      final user = await authRemoteDataSource.signInWithGoogle();
      return Right(user);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      await authRemoteDataSource.signOut();
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Stream<Either<Failure, Auth?>> get currentUser {
    return authRemoteDataSource.currentUser.map(
        (user) => Right(user != null ? Auth.fromFirebaseUser(user) : null));
  }

  @override
  Future<Either<Failure, void>> signInWithPhoneNumber(
    String phoneNumber, {
    required Function(String, int?) codeSent,
    required Function(FirebaseAuthException) verificationFailed,
  }) async {
    try {
      await authRemoteDataSource.signInWithPhoneNumber(
        phoneNumber: phoneNumber,
        codeSent: codeSent,
        verificationFailed: verificationFailed,
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
      return const Right(null); // Use Right for success
    } on FirebaseAuthException catch (e) {
      return Left(ServerFailure(e.message ??
          'Unknown error')); // Replace with a more specific error if needed
    }
  }

  @override
  Future<Either<Failure, void>> verifyPhoneNumber(
      String verificationId, String smsCode) async {
    try {
      await authRemoteDataSource.verifyPhoneNumber(smsCode);
      return const Right(null); // Use Right for success
    } on FirebaseAuthException catch (e) {
      return Left(ServerFailure(e.message ??
          'Unknown error')); // Replace with a more specific error if needed
    }
  }
}
