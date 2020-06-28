import 'package:flutter/material.dart';
import 'package:met/constants.dart';

class SignIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Text(
              'Sign In',
              style: textStyle,
            )
          ],
        ),
      ),
    );
  }
}
