import 'package:flutter/material.dart';
import 'package:met/screens/sign_up_page.dart';
import 'package:met/screens/signin_page.dart';
import 'package:met/screens/upload_file_screen.dart';
import 'package:met/screens/welcome_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData().copyWith(
        primaryColor: Colors.deepOrangeAccent,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        SignInPage.id: (context) => SignInPage(),
        SignUpPage.id: (context) => SignUpPage(),
        UploadScreen.id: (context) => UploadScreen(),
      },
      initialRoute: WelcomeScreen.id,
    );
  }
}
