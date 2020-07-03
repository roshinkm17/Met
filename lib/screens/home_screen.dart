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

class AppBottomNavigationBarController extends StatefulWidget {
  static String id = "home_screen_id";
  @override
  _AppBottomNavigationBarControllerState createState() => _AppBottomNavigationBarControllerState();
}

class _AppBottomNavigationBarControllerState extends State<AppBottomNavigationBarController> {
  final List<Widget> pages = [
    DocumentPreviewPage(),
    SignInPage(),
    SignUpPage(),
    WelcomeScreen(),
  ];
  tabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  int _selectedIndex = 0;
  final PageStorageBucket bucket = PageStorageBucket();
  Widget _bottomNavigationBar(int selectedIndex) => BottomNavigationBar(
        onTap: tabTapped,
        currentIndex: selectedIndex,
        selectedItemColor: primaryColor,
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: false,
        unselectedItemColor: Color(0xffbebebe),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline),
            title: Text('Messages'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            title: Text('Search'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.perm_identity),
            title: Text('Profile'),
          ),
        ],
      );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _bottomNavigationBar(_selectedIndex),
      floatingActionButton: FloatingActionButton(
        child: Icon(FontAwesomeIcons.plus),
        backgroundColor: primaryColor,
        onPressed: () async {
          var result = await Navigator.pushNamed(context, UploadScreen.id);
          if (result == true) {
            tabTapped(1);
            Future.delayed(const Duration(milliseconds: 50), () {
              setState(() {
                tabTapped(0);
              });
            });
          }
        },
        elevation: 20,
        highlightElevation: 0,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      body: PageStorage(
        child: pages[_selectedIndex],
        bucket: bucket,
      ),
    );
  }
}
