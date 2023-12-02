import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:leee3/features/auth/domain/usecases/exports.dart';
import 'core/router/app_router.dart';
import 'features/auth/data/datasources/auth_remote_data_source.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/usecases/get_current_user_usecase.dart';
import 'features/auth/domain/usecases/sign_in_with_google_usecase.dart';
import 'features/auth/domain/usecases/sign_out_usecase.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/auth/presentation/screens/auth_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize FirebaseAuth and GoogleSignIn
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    final GoogleSignIn googleSignIn = GoogleSignIn();

    // Create instances of the data source and repository
    final authRemoteDataSource =
        AuthRemoteDataSource(firebaseAuth, googleSignIn);
    final authRepository = AuthRepositoryImpl(authRemoteDataSource);
    // Create instances of the use cases
    final getCurrentUserUseCase = GetCurrentUser(authRepository);
    final signInWithGoogleUseCase = SignInWithGoogle(authRepository);
    final signOutUseCase = SignOut(authRepository);
    final signInWithPhoneNumberUseCase = SignInWithPhoneNumber(authRepository);
    final verifyPhoneNumberUseCase = VerifyPhoneNumber(authRepository);

    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(
            getCurrentUser: getCurrentUserUseCase,
            signInWithGoogle: signInWithGoogleUseCase,
            signOut: signOutUseCase,
            signInWithPhone: signInWithPhoneNumberUseCase,
            verifyPhoneNumber: verifyPhoneNumberUseCase,
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.yellow),
          useMaterial3: true,
        ),
        onGenerateRoute: onGenerateRoute,
        home: const AuthScreen(),
      ),
    );
  }
}
