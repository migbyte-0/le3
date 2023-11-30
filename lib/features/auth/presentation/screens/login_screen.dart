import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../util/widgets/decorators/index.dart';
import '../../../../util/widgets/decorators/lower_wave_clipper.dart';
import '../bloc/exports.dart';
import '../widgets/index.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Access the AuthBloc instance
    final authBloc = BlocProvider.of<AuthBloc>(context);

    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: SingleChildScrollView(
            child: Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  color: const Color.fromARGB(99, 239, 239, 239),
                  child: Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Center(child: LoginAvatar()),
                      const SizedBox(height: 30),
                      LoginForm(authBloc: authBloc),
                    ],
                  )),
                ),

                // Bottom Right Image
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Image.asset(
                    "lib/assets/images/decorators/splash3.png",
                    color: const Color.fromARGB(80, 144, 59, 13),
                    scale: 5,
                  ),
                ),
                // Bottom Left Image
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: Image.asset(
                    "lib/assets/images/decorators/splash4.png",
                    color: const Color.fromARGB(80, 195, 136, 61),
                    scale: 3,
                  ),
                ),
                ClipPath(
                  clipper: LowerWaveClipper(),
                  child: const GradientContainer(
                    myHeight: 200,
                    firstGradientColor: Color.fromARGB(255, 148, 67, 0),
                    secondGradientColor: Color.fromARGB(255, 84, 42, 6),
                  ),
                ),
                ClipPath(
                  clipper: UpperWaveClipper(),
                  child: const GradientContainer(
                    myHeight: 150,
                    firstGradientColor: Color.fromARGB(255, 103, 47, 10),
                    secondGradientColor: Color.fromARGB(255, 41, 17, 2),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
