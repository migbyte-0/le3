import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SignInWithPhoneNumberRequested extends AuthEvent {
  final String phoneNumber;
  SignInWithPhoneNumberRequested(this.phoneNumber);
}

class PhoneNumberVerificationCompleted extends AuthEvent {
  final String verificationId;
  final String smsCode;
  PhoneNumberVerificationCompleted(this.verificationId, this.smsCode);
}
