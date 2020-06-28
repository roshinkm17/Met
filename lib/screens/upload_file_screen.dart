import 'dart:io';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:status_alert/status_alert.dart';

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

  File file;
  bool _isSaving = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: _isSaving,
        progressIndicator: CircularProgressIndicator(),
        child: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(currentUserEmail),
              Text("Upload Screen"),
              Container(
                color: Colors.orangeAccent.shade200,
                margin: EdgeInsets.symmetric(vertical: 20),
                child: RawMaterialButton(
                  child: Text("Select file"),
                  onPressed: () async {
                    file = await FilePicker.getFile();
                  },
                ),
              ),
              RawMaterialButton(
                onPressed: () async {
                  setState(() {
                    _isSaving = true;
                  });
                  try {
                    StorageReference storageReference = FirebaseStorage()
                        .ref()
                        .child("$currentUserEmail/${basename(file.path)}");
                    StorageUploadTask uploadTask =
                        storageReference.putFile(file);
                    await uploadTask.onComplete;
                    StatusAlert.show(context,
                        duration: Duration(seconds: 2),
                        title: "File Uploaded Successfully",
                        configuration: IconConfiguration(icon: Icons.check),
                        );
                    setState(() {
                      _isSaving = false;
                    });
                  } catch (e) {
                    print(e);
                    setState(() {
                      _isSaving = false;
                    });
                  }
                },
                child: Text("Upload"),
              ),
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
      ),
    );
  }
}
