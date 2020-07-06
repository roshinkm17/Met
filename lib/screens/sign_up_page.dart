import 'package:flutter/material.dart';
import 'package:met/screens/home_screen.dart';
import 'package:met/utilities/custom_buttons.dart';
import '../constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class SignUpPage extends StatefulWidget {
  static String id = "sign_up_page_id";
  SignUpPage({Key key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool visible = false;
  bool _isSaving = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String email, password;
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
                'Sign Up',
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
                obscureText: !visible,
                decoration: InputDecoration(
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        visible ? visible = false : visible = true;
                      });
                    },
                    child: Icon(
                      !visible ? Icons.visibility : Icons.visibility_off,
                      size: 16,
                    ),
                  ),
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
              tag: 'sign-up-button',
              child: SignUpButton(() async {
                setState(() {
                  _isSaving = true;
                });
                try {
                  await _auth.createUserWithEmailAndPassword(email: email, password: password);
                  setState(() {
                    _isSaving = false;
                  });
                  Navigator.pushNamed(context, AppBottomNavigationBarController.id);
                } catch (e) {
                  print(e);
                  setState(() {
                    _isSaving = false;
                  });
                }
              }),
            ),
            SizedBox(height: 30),
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
                style: TextStyle(letterSpacing: .05, fontSize: 16, fontWeight: FontWeight.w300),
              ),
            ),
            Hero(
              tag: 'bottom-icon-row',
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 45, top: 20),
                    child: GestureDetector(
                      onTap: () {},
                      child: Image(
                        image: NetworkImage(
                            'https://cdn4.iconfinder.com/data/icons/logos-and-brands/512/150_Google_logo_logos-512.png'),
                        height: 30,
                        width: 30,
                      ),
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
