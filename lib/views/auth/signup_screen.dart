import 'package:flutter/material.dart';
import '../../widgets/custom_button.dart';

class SignupScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign Up')),
      body: Center(
        child: CustomButton(
          label: 'Sign Up',
          onPressed: () {},
        ),
      ),
    );
  }
}