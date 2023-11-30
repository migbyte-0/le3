import '../repositories/auth_repository.dart';

class VerifyPhoneNumber {
  final AuthRepository repository;
  VerifyPhoneNumber(this.repository);

  Future<void> execute(String verificationId, String smsCode) async {
    return repository.verifyPhoneNumber(verificationId, smsCode);
  }
}
