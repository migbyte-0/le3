// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../../../util/widgets/decorators/index.dart';
// import '../bloc/exports.dart';
// import '../widgets/index.dart';

// class LoginScreen extends StatelessWidget {
//   const LoginScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // Access the AuthBloc instance
//     final authBloc = BlocProvider.of<AuthBloc>(context);

//     return Scaffold(
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Stack(
//             children: [
//               ClipPath(
//                 clipper: WavyClipper(),
//                 child: GradientContainer(
//                   myHeight: MediaQuery.of(context).size.height,
//                   firstGradientColor: const Color.fromARGB(255, 58, 23, 13),
//                   secondGradientColor: const Color.fromARGB(255, 28, 6, 0),
//                   myChild: Directionality(
//                     textDirection: TextDirection.rtl,
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: <Widget>[
//                         const SizedBox(height: 10),
//                         const LoginAvatar(),
//                         const SizedBox(height: 50),
//                         LoginForm(authBloc: authBloc),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               Positioned(
//                 top: 0,
//                 left: 0,
//                 child: Image.asset(
//                   "lib/assets/images/decorators/splash1.png",
//                   color: const Color.fromARGB(30, 171, 139, 116),
//                   scale: 6,
//                 ),
//               ),
//               Positioned(
//                 top: 0,
//                 right: 0,
//                 child: Image.asset(
//                   "lib/assets/images/decorators/splash2.png",
//                   color: const Color.fromARGB(30, 255, 228, 163),
//                   scale: 4,
//                 ),
//               ),
//               // Bottom Right Image
//               Positioned(
//                 bottom: 0,
//                 right: 0,
//                 child: Image.asset(
//                   "lib/assets/images/decorators/splash3.png",
//                   color: const Color.fromARGB(255, 144, 59, 13),
//                   scale: 5,
//                 ),
//               ),
//               // Bottom Left Image
//               Positioned(
//                 bottom: 150,
//                 left: 0,
//                 child: Image.asset(
//                   "lib/assets/images/decorators/splash4.png",
//                   color: const Color.fromARGB(30, 195, 136, 61),
//                   scale: 3,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
