import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/exports.dart';
import 'screens_exports.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // We assume AuthBloc is provided above AuthScreen in the widget tree
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        } else if (state is AuthCodeSent) {
          // Navigate to a new page where the user can enter the verification code
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => VerificationScreen(
                      verificationId: state.verificationId)));
        }
      },
      builder: (context, state) {
        if (state is AuthInitial || state is AuthError) {
          return const LoginScreen(); // Replace with your actual login screen widget
        } else if (state is AuthLoading) {
          return const Center(child: CircularProgressIndicator());
        } else {
          // For simplicity, assume the user is logged in if not in any other state
          return const HomeScreen(); // Replace with your actual home screen widget
        }
      },
    );
  }
}
