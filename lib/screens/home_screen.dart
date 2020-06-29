import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:met/constants.dart';
import 'package:met/screens/upload_file_screen.dart';
import 'package:met/utilities/document_card.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

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
  bool _isSaving = false;

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    return Container(
      color: Colors.white,
      child: Stack(
        children: <Widget>[
          ClipPath(
            clipper: OvalBottomBorderClipper(),
            child: Container(
              color: primaryColor,
              height: deviceHeight * 0.50,
              width: double.infinity,
            ),
          ),
          Scaffold(
              backgroundColor: Colors.transparent,
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  Navigator.pushNamed(context, UploadScreen.id);
                },
                elevation: 30,
                heroTag: "upload_screen",
                highlightElevation: 10,
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
                fixedColor: Colors.black,
                unselectedItemColor: Colors.black54,
                items: [
                  BottomNavigationBarItem(
                    icon: new Icon(Icons.home),
                    title: new Text('Home'),
                  ),
                  BottomNavigationBarItem(
                    icon: new Icon(FontAwesomeIcons.commentAlt),
                    title: new Text('Messages'),
                  ),
                  BottomNavigationBarItem(
                    icon: new Icon(FontAwesomeIcons.search),
                    title: new Text('Search'),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                    title: Text('Profile'),
                  )
                ],
              ),
              body: Padding(
                padding: const EdgeInsets.only(top: 24, left: 14, right: 14),
                child: SafeArea(
                  child: ModalProgressHUD(
                      inAsyncCall: _isSaving,
                      progressIndicator: CircularProgressIndicator(),
                      child: Container(
                        child: ListView(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    CircleAvatar(
                                      radius: 20,
                                      child: Icon(
                                        Icons.person,
                                        color: Colors.white,
                                      ),
                                      backgroundColor: Colors.black87,
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(left: 10),
                                      child: Text(
                                        "John Doe",
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                                IconButton(
                                  icon: Icon(
                                    FontAwesomeIcons.qrcode,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {},
                                )
                              ],
                            ),
                            SizedBox(height: 30),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text("Hi John,",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white)),
                                Text(
                                  "Welcome to MET",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                      height: 1,
                                      color: Colors.white),
                                ),
                                SizedBox(height: 20),
                                Text(
                                  "Upload your important files to MET, \nWe keep it"
                                  " safe here.",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.white),
                                ),
                              ],
                            ),
                            SizedBox(height: 30),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                DocumentCard(),
                                DocumentCard(),
                              ],
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                DocumentCard(),
                                DocumentCard(),
                              ],
                            ),
                          ],
                        ),
                      )),
                ),
              )),
        ],
      ),
    );
  }
}
