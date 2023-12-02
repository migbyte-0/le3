import 'package:flutter/material.dart';
import '../bloc/exports.dart';

class VerificationScreen extends StatelessWidget {
  final AuthBloc authBloc;
  final String verificationId;

  const VerificationScreen({
    super.key,
    required this.authBloc,
    required this.verificationId,
  });

  @override
  Widget build(BuildContext context) {
    String otpCode = ''; // Store the OTP entered by the user

    void verifyOTP() {
      // Implement OTP verification logic
      authBloc.add(PhoneNumberVerificationCompleted(verificationId, otpCode));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Verification Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Enter the OTP code sent to your phone:'),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 80),
              child: TextFormField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Enter OTP',
                ),
                onChanged: (value) {
                  otpCode = value;
                },
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: verifyOTP,
              child: const Text('Verify'),
            ),
          ],
        ),
      ),
    );
  }
}
