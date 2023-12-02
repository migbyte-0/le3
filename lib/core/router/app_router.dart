import 'package:flutter/material.dart';

import '../../features/auth/presentation/screens/index.dart';

Route<dynamic>? onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return MaterialPageRoute(builder: (_) => const SigninScreen());
    case '/phoneInput':
      return MaterialPageRoute(builder: (_) => const PhoneInputScreen());
    case '/otpVerification':
      // Extract the arguments passed, for example, verificationId and phoneNumber
      final args = settings.arguments as Map<String, dynamic>;
      return MaterialPageRoute(
        builder: (_) => OTPVerificationScreen(
          verificationId: args['verificationId'],
          phoneNumber: args['phoneNumber'],
        ),
      );
    default:
      return null;
  }
}
