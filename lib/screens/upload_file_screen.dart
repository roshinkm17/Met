import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:met/screens/document_preview_page.dart';
import 'package:met/utilities/document_property.dart';
import 'package:status_alert/status_alert.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:met/constants.dart';
import 'package:path/path.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UploadScreen extends StatefulWidget {
  UploadScreen({Key key}) : super(key: key);
  static String id = "upload_screen_id";
  @override
  _UploadScreenState createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getFile() async {
    _docProperty.docFile = await FilePicker.getFile();
    setState(() {
      filePath = _docProperty.docFile.path;
      _docProperty.docName = basename(filePath.toString().split('.')[0]);
      _docProperty.docExtension = basename(filePath.toString().split('.')[1]);
      _controller = TextEditingController(text: _docProperty.docName);
    });
  }

  void getCurrentUser() async {
    currentUser = await _auth.currentUser();
    setState(() {
      _docProperty.docOwner = currentUser.email;
    });
  }

  var pageImage;
  TextEditingController _controller;
  String _uploadedFileURL;
  FirebaseUser currentUser;
  String currentUserEmail;
  File file;
  String _errorText;
  bool _dropdownError = false;
  String fileName, documentType, filePath;
  int selectedIndex = 0;
  bool fileSelected = false;
  bool _isSaving = false;
  bool _isExists = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Firestore _firestore = Firestore.instance;

  DocProperty _docProperty = DocProperty();
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
              ),
            ),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 30, top: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
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
                          style: TextStyle(fontWeight: FontWeight.w400, color: Colors.white),
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
                            topRight: Radius.circular(40), topLeft: Radius.circular(40)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            TextField(
                              controller: _controller,
                              onChanged: (value) {
                                _docProperty.docName = value;
                              },
                              decoration: InputDecoration(
                                  errorText: _errorText,
                                  errorStyle: TextStyle(fontSize: 10, color: Colors.red),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey.shade300),
                                  ),
                                  contentPadding: EdgeInsets.only(top: 0),
                                  labelStyle: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w300,
                                      color: Color(0xffbebebe)),
                                  labelText: "Name of the Document"),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
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
                                      _docProperty.docCategory = value;
                                    });
                                  },
                                  isExpanded: true,
                                  hint: Text(
                                    'Type of your document',
                                    style: TextStyle(color: Color(0xffbebebe), fontSize: 18),
                                  ),
                                  value: _docProperty.docCategory,
                                  elevation: 30,
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey,
                                  ),
                                  iconEnabledColor: _dropdownError ? Colors.red : Colors.grey,
                                  iconSize: 30,
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Expanded(
                                  flex: 4,
                                  child: RaisedButton(
                                    elevation: 5,
                                    highlightElevation: 0,
                                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                    color: Color(0xff33b5e5),
                                    textColor: Colors.white,
                                    onPressed: () async {
                                      _isExists = false;
                                      if (_docProperty.docName.isNotEmpty) {
                                        if (_docProperty.docCategory != null) {
                                          Firestore _firestore = Firestore.instance;
                                          var doc = await _firestore
                                              .collection(_docProperty.docOwner)
                                              .getDocuments();
                                          for (var document in doc.documents) {
                                            String documentName = document.data['document name'];
                                            if (documentName == _docProperty.docName) {
                                              setState(() {
                                                _errorText = "Document already exists";
                                                _isExists = true;
                                              });
                                              break;
                                            }
                                          }

                                          if (_isExists == false) {
                                            setState(() {
                                              _isSaving = true;
                                            });
                                            try {
                                              StorageReference storageReference = FirebaseStorage()
                                                  .ref()
                                                  .child(
                                                      "${_docProperty.docOwner}/${_docProperty.docName}");
                                              StorageUploadTask uploadTask =
                                                  storageReference.putFile(_docProperty.docFile);
                                              await uploadTask.onComplete;
                                              storageReference.getDownloadURL().then((fileURL) {
                                                _firestore.collection(_docProperty.docOwner).add({
                                                  "owner": _docProperty.docOwner,
                                                  "document url": fileURL,
                                                  "document name": _docProperty.docName,
                                                  "document extension": _docProperty.docExtension,
                                                  "document category": _docProperty.docCategory,
                                                });
                                                setState(() {
                                                  _isSaving = false;
                                                  fileSelected = false;
                                                });
                                              });
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
                                            } catch (e) {
                                              print(e);
                                              setState(() {
                                                _isSaving = false;
                                              });
                                            }
                                          }
                                        } else {
                                          setState(() {
                                            _errorText = "Type cannot be empty!";
                                          });
                                        }
                                      } else {
                                        setState(() {
                                          _errorText = "Name cannot be empty!";
                                        });
                                      }
                                    },
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: <Widget>[
                                        Icon(Icons.cloud_upload),
                                        Text(
                                          "Upload",
                                          style: TextStyle(fontSize: 20),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: IconButton(
                                    onPressed: () {
                                      getFile();
                                    },
                                    icon: Icon(
                                      FontAwesomeIcons.plus,
                                      size: 16,
                                    ),
                                    color: Color(0xffbebebe),
                                  ),
                                )
                              ],
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
