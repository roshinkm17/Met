import 'package:flutter/material.dart';
import 'package:met/utilities/custom_buttons.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SignUpButton(),
      ),
    );
  }
}
