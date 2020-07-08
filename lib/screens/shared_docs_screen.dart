import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:met/utilities/document_card.dart';
import 'package:met/utilities/document_property.dart';

class SharedDocumentsScreen extends StatefulWidget {
  SharedDocumentsScreen({this.scannedId});
  final String scannedId;

  static String id = "shared_docs_screen_id";

  @override
  _SharedDocumentsScreenState createState() => _SharedDocumentsScreenState();
}

class _SharedDocumentsScreenState extends State<SharedDocumentsScreen> {
  @override
  void initState() {
    super.initState();
    setState(() {
      scannedId = widget.scannedId;
    });
    getTheUid();
  }

  getTheUid() async {
    var doc = _firestore.collection('uids').document(scannedId).get().then((item) {
      setState(() {
        _docProperty.docOwner = item.data['owner'];
      });
    });
  }

  DocProperty _docProperty = DocProperty();
  String scannedId = "";
  Firestore _firestore = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _docProperty.docOwner,
          style: TextStyle(fontSize: 16),
        ),
      ),
      body: SafeArea(
        child: Container(
          child: Center(
              child: Container(
            child: StreamBuilder<QuerySnapshot>(
              stream: _firestore
                  .collection(_docProperty.docOwner == null
                      ? ""
                      : _docProperty.docOwner)
                  .snapshots(),
              builder: (context, snapshot) {
                var card;
                List<Widget> documentCards = [];
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (context, index) {
                      final doc = snapshot.data.documents[index];
                      _docProperty.docName = doc.data["document name"];
                      _docProperty.docURL = doc.data["document url"];
                      _docProperty.docCategory = doc.data["document category"];
                      _docProperty.docExtension =
                          doc.data['document extension'];
                      return new DocumentCard(docProperty: _docProperty);
                    },
                  );
                } else {
                  return Container();
                }
              },
            ),
          )),
        ),
      ),
    );
  }
}
