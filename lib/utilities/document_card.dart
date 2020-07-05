import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:met/screens/home_screen.dart';
import 'package:met/utilities/document_property.dart';
import 'package:met/utilities/viewer.dart';
import 'package:met/constants.dart';
import 'package:status_alert/status_alert.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DocumentCard extends StatefulWidget {
  DocumentCard({this.docProperty});
  final DocProperty docProperty;

  @override
  _DocumentCardState createState() => _DocumentCardState();
}

class _DocumentCardState extends State<DocumentCard> {
  void initState() {
    super.initState();
    setState(() {
      _docProperty.docURL = widget.docProperty.docURL;
      _docProperty.docName = widget.docProperty.docName;
      _docProperty.docExtension = widget.docProperty.docExtension;
      _docProperty.docExtension = widget.docProperty.docExtension;
      _docProperty.docCategory = widget.docProperty.docCategory;
      _docProperty.docOwner = widget.docProperty.docOwner;
    });
  }

  deleteDocument() async {
    StorageReference storageReference =
        FirebaseStorage().ref().child("${_docProperty.docOwner}/${_docProperty.docName}");
    Firestore _firestore = Firestore.instance;
    var doc = await _firestore.collection(_docProperty.docOwner).getDocuments();
    for (var document in doc.documents) {
      String documentName = document.data['document name'];
      if (documentName == _docProperty.docName) {
        document.reference.delete();
        storageReference.delete();
        Navigator.popAndPushNamed(context, AppBottomNavigationBarController.id);
        StatusAlert.show(
          context,
          duration: Duration(seconds: 2),
          title: "Document deleted!",
          configuration: IconConfiguration(
            icon: FontAwesomeIcons.trash,
          ),
        );
      }
    }
  }

  DocProperty _docProperty = DocProperty();
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
                  "${_docProperty.docExtension}",
                  style: TextStyle(color: Colors.orange),
                ),
                FittedBox(
                  fit: BoxFit.fitHeight,
                  child: Text(
                    "${_docProperty.docCategory}",
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
                  "${_docProperty.docName}",
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Viewer(_docProperty.docURL)),
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
