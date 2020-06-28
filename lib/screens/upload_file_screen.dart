import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:file_picker/file_picker.dart';

class UploadScreen extends StatefulWidget {
  static String id = "upload_screen_id";
  @override
  _UploadScreenState createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  FirebaseUser currentUser;
  String currentUserEmail;
  void getCurrentUser() async {
    currentUser = await _auth.currentUser();
    setState(() {
      currentUserEmail = currentUser.email;
    });
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(currentUserEmail),
            Text("Upload Screen"),
            GestureDetector(
              onTap: () async {
                await _auth.signOut();
                Navigator.pop(context);
              },
              child: Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(20),
                color: Colors.black54,
                child: Icon(
                  FontAwesomeIcons.signOutAlt,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
