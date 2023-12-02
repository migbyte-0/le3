import 'package:flutter/material.dart';

class OTPVerificationScreen extends StatelessWidget {
  final String verificationId;
  final String phoneNumber;

  const OTPVerificationScreen({
    super.key,
    required this.verificationId,
    required this.phoneNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('OTP Verification')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 120),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'Enter OTP'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  // Verify OTP entered by the user
                  // You can implement your verification logic here
                },
              ),
              ElevatedButton(
                onPressed: () {
                  // Verify OTP
                  // If successful, proceed with authentication
                  // Else, show an error message
                },
                child: const Text('Submit OTP'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
