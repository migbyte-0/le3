import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  final GoogleSignIn googleSignIn;

  AuthRemoteDataSource(this.firebaseAuth, this.googleSignIn);

  // Store the latest verification ID
  String? _verificationId;

  // Expose verificationId for the BLoC to verify the SMS code
  String? get verificationId => _verificationId;

  Future<User?> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    if (googleUser == null) return null;

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    return (await firebaseAuth.signInWithCredential(credential)).user;
  }

  Future<void> signOut() async {
    await googleSignIn.signOut();
    await firebaseAuth.signOut();
  }

  Future<void> signInWithPhoneNumber({
    required String phoneNumber,
    required Function(String, int?) codeSent,
    required Function(FirebaseAuthException) verificationFailed,
    required Function(String) codeAutoRetrievalTimeout,
  }) async {
    await firebaseAuth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await firebaseAuth.signInWithCredential(credential);
      },
      verificationFailed: verificationFailed,
      codeSent: (String verificationId, int? resendToken) async {
        _verificationId = verificationId;
        codeSent(verificationId, resendToken);
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        _verificationId = verificationId;
        codeAutoRetrievalTimeout(verificationId);
      },
    );
  }

  Future<void> verifyPhoneNumber(String smsCode) async {
    if (_verificationId == null) throw Exception("Verification ID not found");

    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: _verificationId!,
      smsCode: smsCode,
    );

    await firebaseAuth.signInWithCredential(credential);
  }

  Stream<User?> get currentUser => firebaseAuth.authStateChanges();
}
