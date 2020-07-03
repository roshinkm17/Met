import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:met/utilities/document_card.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import '../constants.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DocumentPreviewPage extends StatefulWidget {
  static String id = 'document_preview_page';
  @override
  _DocumentPreviewPageState createState() => _DocumentPreviewPageState();
}

class _DocumentPreviewPageState extends State<DocumentPreviewPage> {
  void getMyDocuments() async {
    FirebaseUser currentUser = await _auth.currentUser();
    currentUserEmail = currentUser.email;
    var doc = await _firestore.collection(currentUserEmail).getDocuments();
    documentCards.clear();
    _count = 0;
    for (var document in doc.documents) {
      setState(() {
        fileName = document.data["document name"];
        fileURL = document.data["document url"];
        fileCategory = document.data["document type"];
        fileType = fileName.split(".")[1];
        fileName = fileName.split(".")[0];
        print(fileName + " " + fileType);
        card = DocumentCard(fileName, fileType, fileURL, fileCategory, currentUserEmail);
        _count++;
        documentCards.add(card);
      });
    }
  }

  void initState() {
    super.initState();
    getMyDocuments();
  }

  int _count = 0;
  DocumentCard card;
  List<DocumentCard> documentCards = [];
  var docs;
  String fileName, fileURL, fileType, fileCategory;
  String currentUserEmail;
  FirebaseAuth _auth = FirebaseAuth.instance;
  Firestore _firestore = Firestore.instance;
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
              body: SafeArea(
                child: ModalProgressHUD(
                    inAsyncCall: _isSaving,
                    progressIndicator: CircularProgressIndicator(),
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(height: 20),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                child: Row(
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
                                            style: TextStyle(fontSize: 20, color: Colors.white),
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
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 30),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text("Hi John,",
                                        style: TextStyle(
                                            fontSize: 30,
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
                                      style: TextStyle(fontSize: 12, color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 30),
                              SizedBox(height: 20),
                            ],
                          ),
                          Expanded(
                            child: Container(
                              child: GridView.count(
                                crossAxisSpacing: 20,
                                mainAxisSpacing: 20,
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                scrollDirection: Axis.vertical,
                                crossAxisCount: 2,
                                children: List.generate(_count, (count) {
                                  return documentCards[count];
                                }),
                              ),
                            ),
                          )
                        ],
                      ),
                    )),
              )),
        ],
      ),
    );
  }
}
