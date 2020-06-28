import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:met/constants.dart';
import 'package:met/screens/sign_up_page.dart';
import 'package:met/screens/signin_page.dart';
import 'package:met/utilities/custom_buttons.dart';

class WelcomeScreen extends StatelessWidget {
  static String id = "welcome_page_id";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
                padding: EdgeInsets.only(right: 100, left: 100, top: 100),
                child: Image(
                    image: AssetImage('images/logo.png'),
                    height: 100,
                    width: 100)),
            SizedBox(
              height: 40,
            ),
            Hero(
              tag: "sign-in-button",
              child: SignInButton(() {
                Navigator.pushNamed(context, SignInPage.id);
              }),
            ),
            SizedBox(
              height: 20,
            ),
            Hero(
              tag: 'sign-up-button',
              child: SignUpButton(() {
                Navigator.pushNamed(context, SignUpPage.id);
              }),
            ),
            SizedBox(
              height: 20,
            ),
            Hero(
              tag: 'bottom-line-row',
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Divider(
                      indent: 30,
                      endIndent: 10,
                      thickness: 1,
                      color: Colors.black38,
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Text(
                    'OR',
                    style: textStyle.copyWith(fontSize: 14),
                  ),
                  Expanded(
                    child: Divider(
                      endIndent: 30,
                      indent: 10,
                      thickness: 1,
                      color: Colors.black38,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 45),
              child: Text(
                'Sign-up with the help of Google or Sign-up with Microsoft',
                style: TextStyle(
                    letterSpacing: .05,
                    fontSize: 16,
                    fontWeight: FontWeight.w300),
              ),
            ),
            Hero(
              tag: 'bottom-icon-row',
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 45, top: 20),
                    child: Icon(
                      FontAwesomeIcons.google,
                      size: 25,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10, top: 20),
                    child: Icon(
                      FontAwesomeIcons.microsoft,
                      size: 25,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
