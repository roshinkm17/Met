import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:met/constants.dart';
import 'package:custom_navigator/custom_navigation.dart';
import 'package:met/screens/document_preview_page.dart';
import 'package:met/screens/sign_in_page.dart';
import 'package:met/screens/sign_up_page.dart';
import 'package:met/screens/upload_file_screen.dart';
import 'package:met/screens/welcome_page.dart';

class HomeScreen extends StatefulWidget {
  static String id = "home_screen_id";
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void onTabTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Stack(
        children: <Widget>[
          CustomScaffold(
            scaffold: Scaffold(
              backgroundColor: Colors.transparent,
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  Navigator.pushNamed(context, UploadScreen.id);
                },
                elevation: 10,
                heroTag: "upload_screen_tag",
                highlightElevation: 0,
                backgroundColor: primaryColor,
                child: Icon(FontAwesomeIcons.plus),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                showUnselectedLabels: false,
                currentIndex: selectedIndex,
                onTap: onTabTapped,
                unselectedItemColor: Colors.black54,
                items: [
                  BottomNavigationBarItem(
                    icon: new Icon(Icons.home),
                    title: new Text('Home'),
                  ),
                  BottomNavigationBarItem(
                    icon: new Icon(Icons.chat_bubble_outline),
                    title: new Text('Messages'),
                  ),
                  BottomNavigationBarItem(
                    icon: new Icon(Icons.search),
                    title: new Text('Search'),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.perm_identity),
                    title: Text('Profile'),
                  )
                ],
              ),
            ),
            children: <Widget>[
              DocumentPreviewPage(),
              SignInPage(),
              SignUpPage(),
              WelcomeScreen(),
            ],
          ),
        ],
      ),
    );
  }
}
