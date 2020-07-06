import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:met/screens/home_screen.dart';
import 'package:met/utilities/document_property.dart';
import 'package:met/utilities/viewer.dart';
import 'package:met/constants.dart';
import 'package:status_alert/status_alert.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';

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
      _docProperty.docExtension = document.data['document extension'];
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

  changeDocument() async {
    _docProperty.docFile = await FilePicker.getFile();
    setState(() {
      _isSaving = true;
    });
    StorageReference storageReference =
        FirebaseStorage().ref().child("${_docProperty.docOwner}/${_docProperty.docName}");
    Firestore _firestore = Firestore.instance;
    var docs = await _firestore.collection(_docProperty.docOwner).getDocuments();
    StorageUploadTask uploadTask = storageReference.putFile(_docProperty.docFile);
    await uploadTask.onComplete;
    storageReference.getDownloadURL().then((fileURL) {
      for (var document in docs.documents) {
        String documentName = document.data['document name'];
        if (documentName == _docProperty.docName) {
          document.reference.updateData({'document url': fileURL});
          setState(() {
            _isSaving = false;
          });
          Navigator.popAndPushNamed(context, AppBottomNavigationBarController.id);
          StatusAlert.show(
            context,
            duration: Duration(seconds: 2),
            title: "Document Updated!",
            configuration: IconConfiguration(
              icon: FontAwesomeIcons.check,
            ),
          );
        }
      }
    });
  }

  DocProperty _docProperty = DocProperty();
  bool _isSaving = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          )
        ],
      ),
      child: _isSaving == false
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        _docProperty.docExtension,
                        style: TextStyle(color: Color(0xffbebebe), fontSize: 12),
                      ),
                      Wrap(
                        direction: Axis.horizontal,
                        children: <Widget>[
                          Text(
                            _docProperty.docName,
                            style: TextStyle(color: secondaryColor, fontSize: 20),
                          ),
                        ],
                      ),
                      Text(
                        _docProperty.docCategory,
                        style: TextStyle(color: secondaryColor, fontSize: 16),
                      ),
                      IconButton(
                        icon: Icon(FontAwesomeIcons.trash, color: Colors.grey),
                        iconSize: 16,
                        onPressed: () {
                          deleteDocument();
                        },
                      )
                    ],
                  ),
                ),
                Column(
                  children: <Widget>[
                    FlatButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      color: primaryColor,
                      child: Text(
                        "View",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: ((context) => Viewer(_docProperty))));
                      },
                    ),
                    FlatButton(
                      child: Text("Change"),
                      shape: OutlineInputBorder(borderSide: BorderSide(color: secondaryColor)),
                      onPressed: () {
                        StorageReference storageReference = FirebaseStorage()
                            .ref()
                            .child("${_docProperty.docOwner}/${_docProperty.docName}");
                        storageReference.delete();
                        changeDocument();
                      },
                    )
                  ],
                ),
              ],
            )
          : Center(child: Container(height: 20, width: 20, child: CircularProgressIndicator())),
    );
  }
}
