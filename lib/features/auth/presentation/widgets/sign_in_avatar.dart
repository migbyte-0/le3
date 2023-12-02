import 'package:flutter/material.dart';
import 'package:leee3/util/widgets/decorators/gradient_icon.dart';

class LoginAvatar extends StatelessWidget {
  const LoginAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    // Use MediaQuery for responsive design
    var size = MediaQuery.of(context).size;
    var avatarSize = size.width * 0.4; // 30% of screen width

    return Center(
      child: GradientIcon(
        firstGradientColor: const Color.fromARGB(255, 255, 89, 0),
        secondGradientColor: const Color.fromARGB(255, 88, 35, 6),
        myChild: Image.asset(
          scale: 5,
          'lib/assets/images/icons/logo.png',
        ),
      ),
    );
  }
}
