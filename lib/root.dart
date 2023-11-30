import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'features/auth/data/datasources/auth_remote_data_source.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/usecases/exports.dart';
import 'features/auth/presentation/bloc/exports.dart';
import 'features/auth/presentation/screens/screens_exports.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Create instances of the use cases
    final authRemoteDataSource = AuthRemoteDataSource(FirebaseAuth.instance);
    final authRepository = AuthRepositoryImpl(authRemoteDataSource);
    final getCurrentUserUseCase = GetCurrentUser(authRepository);
    final signInWithPhoneUseCase = SignInWithPhone(authRepository);
    final verifyPhoneNumberUseCase = VerifyPhoneNumber(authRepository);

    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(
            getCurrentUser: getCurrentUserUseCase,
            signInWithPhone: signInWithPhoneUseCase,
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
        home: const AuthScreen(),
      ),
    );
  }
}
