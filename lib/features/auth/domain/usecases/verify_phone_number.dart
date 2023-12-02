import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../domain/repositories/auth_repository.dart';

class VerifyPhoneNumber {
  final AuthRepository authRepository;

  VerifyPhoneNumber(this.authRepository);

  Future<Either<Failure, void>> call({
    required String verificationId,
    required String smsCode,
  }) async {
    return await authRepository.verifyPhoneNumber(
      verificationId,
      smsCode,
    );
  }
}
