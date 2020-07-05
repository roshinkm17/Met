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
    UploadScreen(),
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
            icon: Icon(Icons.cloud_upload),
            title: Text('Upload'),
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
      resizeToAvoidBottomPadding: false,
      bottomNavigationBar: _bottomNavigationBar(_selectedIndex),
      floatingActionButton: _selectedIndex != 1
          ? FloatingActionButton.extended(
              label: Text("Upload"),
              isExtended: true,
              icon: Icon(FontAwesomeIcons.fileUpload),
              backgroundColor: primaryColor,
              onPressed: () {
                setState(() {
                  _selectedIndex = 1;
                });
              },
              elevation: 20,
              highlightElevation: 0,
            )
          : Container(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      body: PageStorage(
        child: pages[_selectedIndex],
        bucket: bucket,
      ),
    );
  }
}
