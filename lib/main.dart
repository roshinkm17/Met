import 'package:flutter/material.dart';
import 'package:met/constants.dart';
import 'package:met/screens/document_preview_page.dart';
import 'package:met/screens/home_screen.dart';
import 'package:met/screens/share_screen.dart';
import 'package:met/screens/shared_docs_screen.dart';
import 'package:met/screens/sign_up_page.dart';
import 'package:met/screens/sign_in_page.dart';
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
      theme: ThemeData(
        fontFamily: 'Poppins',
        primaryColor: primaryColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        SignInPage.id: (context) => SignInPage(),
        SignUpPage.id: (context) => SignUpPage(),
        UploadScreen.id: (context) => UploadScreen(),
        ShareScreen.id: (context) => ShareScreen(),
        SharedDocumentsScreen.id: (context) => SharedDocumentsScreen(),
        DocumentPreviewPage.id: (context) => DocumentPreviewPage(),
        AppBottomNavigationBarController.id: (context) => AppBottomNavigationBarController(),
      },
      initialRoute: WelcomeScreen.id,
    );
  }
}
