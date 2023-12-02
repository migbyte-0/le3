import 'package:flutter/material.dart';
import 'package:leee3/util/styles/styles.dart';
import 'package:leee3/util/widgets/style/buttons_style.dart';

import '../bloc/exports.dart'; // Ensure this path is correct for your project

class GoogleSignInButton extends StatelessWidget {
  final VoidCallback onPressed;

  const GoogleSignInButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'التسجبل عبر قوقل',
            style: Styles.styleBoldOrange16,
          ),
          const SizedBox(width: 20),
          Image.asset(
            'lib/assets/images/icons/google.png',
            scale: 15,
          )
        ],
      ),
    );
  }
}
