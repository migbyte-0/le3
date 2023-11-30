import 'package:firebase_auth/firebase_auth.dart';
import '../../domain/entities/auth_entities.dart';

class AuthRemoteDataSource {
  final FirebaseAuth firebaseAuth;

  AuthRemoteDataSource(this.firebaseAuth);

  // Store the latest verification ID
  String? _verificationId;

  // Expose verificationId for the BLoC to verify the SMS code
  String? get verificationId => _verificationId;

  // Initiates the phone authentication process
  Future<void> signInWithPhoneNumber(
    String phoneNumber, {
    required Function(String verificationId, int? resendToken) codeSent,
    required Function(FirebaseAuthException error) verificationFailed,
  }) async {
    await firebaseAuth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        // Auto-retrieval or instant verification
        await firebaseAuth.signInWithCredential(credential);
        // Notify your app that the user has been successfully verified and signed in
      },
      verificationFailed: verificationFailed,
      codeSent: (String verificationId, int? resendToken) async {
        _verificationId = verificationId;
        codeSent(verificationId, resendToken);
        // Notify your app that the verification code has been sent
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        _verificationId = verificationId;
        // Notify your app that the code auto retrieval has timed out
      },
    );
  }

  // Verifies the SMS code and signs the user in
  Future<void> verifyPhoneNumber(String smsCode) async {
    if (_verificationId == null) throw Exception("Verification ID not found");

    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: _verificationId!,
      smsCode: smsCode,
    );

    await firebaseAuth.signInWithCredential(credential);
    // Notify your app that the user has been successfully verified and signed in
  }

  // Listens to the FirebaseAuth user and maps it to your domain's Auth entity
  Stream<Auth?> get currentUser {
    return firebaseAuth.authStateChanges().map((User? user) {
      if (user == null) {
        return null;
      } else {
        // Assuming you have a constructor in Auth for creating from Firebase User
        return Auth(
          id: user.uid,
          phoneNumber: user.phoneNumber ?? '',
          name: user.displayName ?? '',
        );
      }
    });
  }
}
