import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:met/utilities/document_card.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import '../constants.dart';

class DocumentPreviewPage extends StatefulWidget {
  @override
  _DocumentPreviewPageState createState() => _DocumentPreviewPageState();
}

class _DocumentPreviewPageState extends State<DocumentPreviewPage> {
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
                      child: ListView(
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
              )),
        ],
      ),
    );
  }
}
