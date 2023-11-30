import 'package:flutter/material.dart';

class VerificationScreen extends StatelessWidget {
  final String verificationId;

  const VerificationScreen({super.key, required this.verificationId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amberAccent,
      ),
    );
  }

  // Add your verification code form fields and a button to submit the code
  // When submitted, dispatch PhoneNumberVerificationCompleted event to the AuthBloc
}
