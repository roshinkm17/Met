import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:status_alert/status_alert.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:met/constants.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:met/show_preview.dart';

class UploadScreen extends StatefulWidget {
  static String id = "upload_screen_id";
  @override
  _UploadScreenState createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  void initState() {
    super.initState();
    getCurrentUser();
    getFile();
  }

  void getFile() async {
    file = await FilePicker.getFile();
  }

  var pageImage;
  String _uploadedFileURL;
  FirebaseUser currentUser;
  String currentUserEmail;
  void getCurrentUser() async {
    currentUser = await _auth.currentUser();
    setState(() {
      currentUserEmail = currentUser.email;
    });
  }

  File file;
  String fileName, documentType;
  int selectedIndex = 0;
  bool fileSelected = false;
  bool _isSaving = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String _value;
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "upload_screen_tag",
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        body: ModalProgressHUD(
          inAsyncCall: _isSaving,
          progressIndicator: CircularProgressIndicator(),
          child: Container(
//        color: Color(0xffffb577),
            decoration: BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
              colors: [Colors.orangeAccent, primaryColor],
            )),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 30, top: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                          ),
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.black,
                          child: Icon(Icons.person, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Welcome",
                          style: TextStyle(
                              fontWeight: FontWeight.w400, color: Colors.white),
                        ),
                        SizedBox(height: 20),
                        Text(
                          "Keep your \nDocuments safe.",
                          style: TextStyle(
                              height: 1.2,
                              fontWeight: FontWeight.w700,
                              fontSize: 30,
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(40),
                            topLeft: Radius.circular(40)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            TextField(
                              onChanged: (value) {
                                fileName = value;
                              },
                              decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey.shade300)),
                                  contentPadding: EdgeInsets.only(top: 0),
                                  labelStyle: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w300,
                                      color: Color(0xffbebebe)),
                                  labelText: "Name of the Document"),
                            ),
                            SizedBox(height: 20),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 5),
                              margin: EdgeInsets.only(bottom: 20),
                              decoration: BoxDecoration(
                                color: Color(0xffebebeb),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  items: [
                                    DropdownMenuItem<String>(
                                      child: Text('Aadhar'),
                                      value: 'Aadhar',
                                    ),
                                    DropdownMenuItem<String>(
                                      child: Text('Driving License'),
                                      value: 'License',
                                    ),
                                    DropdownMenuItem<String>(
                                      child: Text('Others'),
                                      value: 'others',
                                    ),
                                  ],
                                  onChanged: (String value) {
                                    setState(() {
                                      _value = value;
                                      documentType = value;
                                    });
                                  },
                                  isExpanded: true,
                                  hint: Text(
                                    'Type of your document',
                                    style: TextStyle(
                                        color: Color(0xffbebebe), fontSize: 18),
                                  ),
                                  value: _value,
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey,
                                  ),
                                  iconEnabledColor: Colors.grey,
                                  iconSize: 30,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0xfff6f6f6),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                width: double.infinity,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(
                                      Icons.remove_red_eye,
                                      color: Color(0xffbebebe),
                                      size: 40,
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      "Preview",
                                      style: TextStyle(
                                          color: Color(0xffbebebe),
                                          fontSize: 20,
                                          fontWeight: FontWeight.w200),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              padding:
                                  EdgeInsets.only(top: 20, left: 30, right: 30),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(FontAwesomeIcons.edit),
                                    color: Color(0xffbebebe),
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      setState(() {
                                        _isSaving = true;
                                      });
                                      try {
                                        StorageReference storageReference =
                                            FirebaseStorage().ref().child(
                                                "$currentUserEmail/$fileName");
                                        StorageUploadTask uploadTask =
                                            storageReference.putFile(file);
                                        await uploadTask.onComplete;
                                        setState(() {
                                          _isSaving = false;
                                        });
                                        StatusAlert.show(
                                          context,
                                          duration: Duration(seconds: 2),
                                          title: "File Uploaded Successfully",
                                          configuration: IconConfiguration(
                                            icon: Icons.check,
                                          ),
                                        );
                                        storageReference
                                            .getDownloadURL()
                                            .then((fileURL) {
                                          setState(() {
                                            _uploadedFileURL = fileURL;
                                            print(_uploadedFileURL);
                                            _isSaving = false;
                                            fileSelected = false;
                                          });
                                        });
                                      } catch (e) {
                                        print(e);
                                        setState(() {
                                          _isSaving = false;
                                        });
                                      }
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(20),
                                      decoration: BoxDecoration(
                                        color: Color(0xff33b5e5),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Icon(
                                        Icons.cloud_upload,
                                        size: 30,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(FontAwesomeIcons.folderOpen),
                                    color: Color(0xffbebebe),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
