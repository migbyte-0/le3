import 'package:flutter/material.dart';
import 'package:leee3/util/styles/styles.dart';
import 'package:leee3/util/widgets/style/buttons_style.dart';

import '../bloc/exports.dart'; // Ensure this path is correct for your project

class LoginForm extends StatelessWidget {
  final AuthBloc authBloc;

  const LoginForm({super.key, required this.authBloc});

  @override
  Widget build(BuildContext context) {
    final phoneNumberController = TextEditingController();

    return Padding(
      padding: const EdgeInsets.only(left: 40, right: 40),
      child: Card(
        elevation: 20,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                // maxLength: 9,
                controller: phoneNumberController,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  labelText: "رقم الجوال",
                  prefixText: '+669',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    borderSide: BorderSide.none,
                  ),
                ),
                keyboardType: TextInputType.phone,
                onFieldSubmitted: (_) {
                  authBloc.add(SignInWithPhoneNumberRequested(
                      phoneNumberController.text));
                },
              ),
              const SizedBox(height: 20),
              RoundedButton(
                text: 'تسجيل دخول',
                onPressed: () {
                  // Dispatch the event to the bloc
                  authBloc.add(SignInWithPhoneNumberRequested(
                      phoneNumberController.text));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
