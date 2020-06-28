import 'package:flutter/material.dart';
import 'package:met/constants.dart';
import 'package:met/screens/upload_file_screen.dart';
import 'package:met/utilities/custom_buttons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class SignInPage extends StatefulWidget {
  static String id = "sign_in_page_id";

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String email, password;
  bool _isSaving = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: ModalProgressHUD(
        inAsyncCall: _isSaving,
        progressIndicator: CircularProgressIndicator(
          strokeWidth: 5,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                'Sign In',
                style: textStyle.copyWith(fontSize: 30),
                textAlign: TextAlign.start,
              ),
            ),
            SizedBox(height: 30),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 40),
              child: TextField(
                onChanged: (value) {
                  email = value;
                },
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: "Email",
                  labelStyle: TextStyle(fontSize: 16, color: Colors.black54),
                  contentPadding: EdgeInsets.only(left: 30),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black45),
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 40),
              child: TextField(
                onChanged: (value) {
                  password = value;
                },
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(fontSize: 16, color: Colors.black54),
                  contentPadding: EdgeInsets.only(left: 30),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black45),
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
            Hero(
              tag: 'sign-in-button',
              child: SignInButton(() async {
                setState(() {
                  _isSaving = true;
                });
                try {
                  await _auth.signInWithEmailAndPassword(
                      email: email, password: password);
                  setState(() {
                    _isSaving = true;
                  });
                  Navigator.pushNamed(context, UploadScreen.id);
                  setState(() {
                    _isSaving = false;
                  });
                } catch (e) {
                  print(e);
                  setState(() {
                    _isSaving = true;
                  });
                }
              }),
            ),
            SizedBox(height: 30),
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