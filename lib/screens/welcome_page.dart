import 'package:flutter/material.dart';
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
              height: 80,
            ),
            Hero(
              tag: "sign-in-button",
              child: SignInButton(() {
                Navigator.pushNamed(context, SignInPage.id);
              }),
            ),
            SizedBox(
              height: 5,
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
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
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
                    child: Image(
                      image: NetworkImage(
                          'https://cdn4.iconfinder.com/data/icons/logos-and-brands/512/150_Google_logo_logos-512.png'),
                      height: 30,
                      width: 30,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20, top: 20),
                    child: Image(
                      image: NetworkImage(
                          'https://cdn0.iconfinder.com/data/icons/shift-logotypes/32/Microsoft-512.png'),
                      height: 30,
                      width: 30,
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
