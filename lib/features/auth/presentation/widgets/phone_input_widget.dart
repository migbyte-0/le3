import 'package:flutter/material.dart';

class SigninWithPhoneWidget extends StatefulWidget {
  const SigninWithPhoneWidget({super.key});

  @override
  _SigninWithPhoneWidgetState createState() => _SigninWithPhoneWidgetState();
}

class _SigninWithPhoneWidgetState extends State<SigninWithPhoneWidget> {
  final TextEditingController _phoneController = TextEditingController();
  String? phoneNumberError;

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
      child: Column(
        children: [
          TextFormField(
            maxLength: 9,
            controller: _phoneController,
            decoration: InputDecoration(
              // prefixText: '+966 ',
              prefixIcon: const Icon(
                Icons.phone_iphone_rounded,
                color: Colors.deepOrange,
              ),
              suffixIcon: IconButton(
                icon: const Icon(
                  Icons.clear,
                ),
                onPressed: () {
                  setState(() {
                    _phoneController.clear();
                    phoneNumberError = null;
                  });
                },
              ),
              fillColor: Colors.white,
              filled: true,
              hintText: 'xxxxxxxx5',
              labelText: 'رقم الجوال',
              errorText: phoneNumberError,
            ),
            keyboardType: TextInputType.phone,
            onChanged: (value) {
              setState(() {
                if (value.isEmpty) {
                  phoneNumberError = 'Please enter a phone number';
                } else if (!RegExp(r'^5[0-9]{8}$').hasMatch(value)) {
                  phoneNumberError =
                      'Phone number should start with 5 and be 9 digits long';
                } else {
                  phoneNumberError = null;
                }
              });
            },
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              if (phoneNumberError == null) {
                // Check phone number validity and navigate to OTP verification screen
                Navigator.pushNamed(
                  context,
                  '/otpVerification',
                  arguments: {
                    'verificationId':
                        'YOUR_VERIFICATION_ID', // Pass the verificationId here
                    'phoneNumber': '+966 ${_phoneController.text}',
                  },
                );
              }
            },
            child: const Text('دخول'),
          )
        ],
      ),
    );
  }
}
