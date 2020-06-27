import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:met/constants.dart';
import 'package:met/utilities/custom_buttons.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(right: 100, left: 100, top: 100),
              child: Image.asset('images/logo.png'),
            ),
            SizedBox(
              height: 40,
            ),
            SignInButton(),
            SizedBox(
              height: 20,
            ),
            SignUpButton(),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Divider(
                    indent: 30,
                    endIndent: 10,
                    thickness: 2,
                    color: Colors.black54,
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Text(
                  'OR',
                  style: textStyle.copyWith(fontSize: 16),
                ),
                Expanded(
                  child: Divider(
                    endIndent: 30,
                    indent: 10,
                    thickness: 2,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            Text(
              'Signup with the help of Google or \nSignup with Microsoft',
              style: textStyle.copyWith(letterSpacing: .05),
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 35, top: 20),
                  child: Icon(
                    FontAwesomeIcons.google,
                    size: 35,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10, top: 20),
                  child: Icon(
                    FontAwesomeIcons.microsoft,
                    size: 35,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
