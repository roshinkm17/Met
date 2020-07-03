import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:met/screens/home_screen.dart';
import 'package:met/utilities/viewer.dart';
import 'package:met/constants.dart';
import 'package:status_alert/status_alert.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DocumentCard extends StatefulWidget {
  DocumentCard(
      this.fileName, this.fileType, this.fileUrl, this.fileCategory, this.currentUserEmail);
  final String fileType, fileName, fileUrl, fileCategory;
  final String currentUserEmail;

  @override
  _DocumentCardState createState() => _DocumentCardState();
}

class _DocumentCardState extends State<DocumentCard> {
  void initState() {
    super.initState();
    setState(() {
      fileName = widget.fileName;
      fileType = widget.fileType;
      fileUrl = widget.fileUrl;
      fileCategory = widget.fileCategory;
      currentUserEmail = widget.currentUserEmail;
    });
  }

  deleteDocument() async {
    StorageReference storageReference =
        FirebaseStorage().ref().child("$currentUserEmail/$fileName");
    Firestore _firestore = Firestore.instance;
    var doc = await _firestore.collection(currentUserEmail).getDocuments();
    for (var document in doc.documents) {
      String documentName = document.data['document name'];
      documentName = documentName.split(".")[0];
      if (documentName == fileName) {
        setState(() {
          document.reference.delete();
          storageReference.delete();
          Navigator.pushNamed(context, AppBottomNavigationBarController.id);
          StatusAlert.show(
            context,
            duration: Duration(seconds: 2),
            title: "Document deleted!",
            configuration: IconConfiguration(
              icon: FontAwesomeIcons.trash,
            ),
          );
        });
      }
    }
  }

  String fileType, fileName, fileUrl, urlPdfPath, fileCategory;
  String currentUserEmail;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(
                  "$fileType",
                  style: TextStyle(color: Colors.orange),
                ),
                FittedBox(
                  fit: BoxFit.fitHeight,
                  child: Text(
                    "$fileCategory",
                    style: TextStyle(color: primaryColor),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FittedBox(
                fit: BoxFit.fitHeight,
                child: Text(
                  "${widget.fileName}",
                  style: TextStyle(color: Color(0xffABABAB), fontSize: 20),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RaisedButton(
                  elevation: 0,
                  color: Color(0xff4caf50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  onPressed: () {
                    print(fileUrl);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Viewer(fileUrl)),
                    );
                    setState(() {});
                  },
                  child: Text(
                    "view",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    deleteDocument();
                  },
                  icon: Icon(FontAwesomeIcons.trash),
                  iconSize: 14,
                  color: Colors.red.shade300,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
