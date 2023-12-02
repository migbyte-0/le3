import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SignInWithGoogleEvent extends AuthEvent {}

class SignOutEvent extends AuthEvent {}

class SignInWithPhoneNumberRequested extends AuthEvent {
  final String phoneNumber;

  SignInWithPhoneNumberRequested(this.phoneNumber);

  @override
  List<Object?> get props => [phoneNumber];
}

class PhoneNumberVerificationCompleted extends AuthEvent {
  final String verificationId;
  final String smsCode;

  PhoneNumberVerificationCompleted(this.verificationId, this.smsCode);

  @override
  List<Object?> get props => [verificationId, smsCode];
}
