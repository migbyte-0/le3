import 'package:bloc/bloc.dart';

import '../../domain/usecases/exports.dart';
import 'exports.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignInWithGoogle signInWithGoogle;
  final SignOut signOut;
  final SignInWithPhoneNumber signInWithPhone;
  final VerifyPhoneNumber verifyPhoneNumber;

  AuthBloc({
    required this.signInWithGoogle,
    required this.signOut,
    required this.signInWithPhone,
    required this.verifyPhoneNumber,
    required GetCurrentUser getCurrentUser,
  }) : super(AuthInitial()) {
    on<SignInWithGoogleEvent>(_onSignInWithGoogle);
    on<SignOutEvent>(_onSignOut);
    on<SignInWithPhoneNumberRequested>(_onSignInWithPhoneNumberRequested);
    on<PhoneNumberVerificationCompleted>(_onPhoneNumberVerificationCompleted);
  }

  Future<void> _onSignInWithGoogle(
    SignInWithGoogleEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    final result = await signInWithGoogle.execute();
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (user) => emit(Authenticated(user)),
    );
  }

  Future<void> _onSignOut(
    SignOutEvent event,
    Emitter<AuthState> emit,
  ) async {
    await signOut.execute();
    emit(AuthInitial());
  }

  Future<void> _onSignInWithPhoneNumberRequested(
    SignInWithPhoneNumberRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      await signInWithPhone.call(
        // Remove the positional arguments
        phoneNumber: event.phoneNumber,
        codeSent: (verificationId, resendToken) {
          if (!emit.isDone) {
            emit(AuthCodeSent(verificationId));
          }
        },
        verificationFailed: (exception) {
          if (!emit.isDone) {
            emit(AuthError(exception.message ?? 'Verification failed'));
          }
        },
      );
    } catch (error) {
      if (!emit.isDone) {
        emit(AuthError(error.toString()));
      }
    }
  }

  Future<void> _onPhoneNumberVerificationCompleted(
    PhoneNumberVerificationCompleted event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      await verifyPhoneNumber.call(
        // Remove the positional arguments
        verificationId: event.verificationId,
        smsCode: event.smsCode,
      );
      // You may want to emit a state that indicates the user is authenticated
    } catch (error) {
      emit(AuthError(error.toString()));
    }
  }
}
