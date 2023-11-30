import 'package:bloc/bloc.dart';

import '../../domain/usecases/exports.dart';
import 'exports.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final GetCurrentUser getCurrentUser;
  final SignInWithPhone signInWithPhone;
  final VerifyPhoneNumber verifyPhoneNumber;

  AuthBloc({
    required this.getCurrentUser,
    required this.signInWithPhone,
    required this.verifyPhoneNumber,
  }) : super(AuthInitial()) {
    on<SignInWithPhoneNumberRequested>(_onSignInWithPhoneNumberRequested);
    on<PhoneNumberVerificationCompleted>(_onPhoneNumberVerificationCompleted);
  }

  Future<void> _onSignInWithPhoneNumberRequested(
    SignInWithPhoneNumberRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      await signInWithPhone.execute(
        event.phoneNumber,
        codeSent: (verificationId, resendToken) {
          emit(AuthCodeSent(verificationId));
        },
        verificationFailed: (exception) {
          emit(AuthError(exception.message!));
        },
      );
    } catch (error) {
      emit(AuthError(error.toString()));
    }
  }

  Future<void> _onPhoneNumberVerificationCompleted(
    PhoneNumberVerificationCompleted event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      await verifyPhoneNumber.execute(event.verificationId, event.smsCode);
      // You may want to emit a state that indicates the user is authenticated
    } catch (error) {
      emit(AuthError(error.toString()));
    }
  }
}
