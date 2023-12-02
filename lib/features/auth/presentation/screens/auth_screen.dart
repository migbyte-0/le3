import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../data/datasources/auth_remote_data_source.dart'
    as RemoteDataSource;
import '../../data/repositories/auth_repository_impl.dart' as AuthRepo;
import '../../domain/usecases/exports.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_state.dart';
import 'screens_exports.dart';
import 'verification_screen.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    final authRemoteDataSource =
        RemoteDataSource.AuthRemoteDataSource(firebaseAuth, GoogleSignIn());
    final authRepository = AuthRepo.AuthRepositoryImpl(authRemoteDataSource);
    final getCurrentUser = GetCurrentUser(authRepository);
    final signInWithGoogle = SignInWithGoogle(authRepository);
    final signOut = SignOut(authRepository);
    final signInWithPhone = SignInWithPhoneNumber(authRepository);
    final verifyPhoneNumber = VerifyPhoneNumber(authRepository);

    return Scaffold(
      body: BlocProvider<AuthBloc>(
        create: (context) => AuthBloc(
          getCurrentUser: getCurrentUser,
          signInWithGoogle: signInWithGoogle,
          signOut: signOut,
          signInWithPhone: signInWithPhone,
          verifyPhoneNumber: verifyPhoneNumber,
        ),
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthCodeSent) {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => VerificationScreen(
                  authBloc: BlocProvider.of<AuthBloc>(context),
                  verificationId: state.verificationId,
                ),
              ));
            } else if (state is Authenticated) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const HomeScreen()),
              );
            } else if (state is AuthError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          child: const SigninScreen(),
        ),
      ),
    );
  }
}
