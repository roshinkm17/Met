import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:met/constants.dart';
import 'package:met/screens/shared_docs_screen.dart';
import 'package:met/utilities/document_property.dart';
import 'package:met/utilities/qr_code_generator.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:met/utilities/scanner.dart';

class ShareScreen extends StatefulWidget {
  ShareScreen({Key key}) : super(key: key);
  static String id = 'share_screen_page_id';

  @override
  _ShareScreenState createState() => _ShareScreenState();
}

class _ShareScreenState extends State<ShareScreen> {
  void initState() {
    super.initState();
    _getUid();
  }

  scanResults() async {
    result = await FlutterBarcodeScanner.scanBarcode("#ffffff", 'cancel', true, ScanMode.QR);
    // ignore: unnecessary_statements
    result != null
        ? Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SharedDocumentsScreen(
                      scannedId: result,
                    )))
        // ignore: unnecessary_statements
        : "";
  }

  _getUid() async {
    Firestore _firestore = Firestore.instance;
    currentUser = await _auth.currentUser();
    setState(() {
      id = uid.v5(Uuid.NAMESPACE_URL, currentUser.email);
    });
    _firestore.collection('uids').document(id).setData({"owner": currentUser.email, "uid": id});
  }

  String id;
  var uid = Uuid();
  QRCode qrCode = QRCode();
  var result;
  FirebaseUser currentUser;
  FirebaseAuth _auth = FirebaseAuth.instance;
  DocProperty _docProperty = DocProperty();

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 3,
                    spreadRadius: 1,
                    offset: Offset(3, 3),
                    color: Colors.grey.shade300,
                  )
                ],
              ),
              width: deviceWidth * 0.6,
              padding: EdgeInsets.all(10),
              child: QRCode(data: id == null ? "" : id),
            ),
            SizedBox(height: 30),
            Text(
              "John Doe",
              style: TextStyle(color: Colors.black, fontSize: 22, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 30),
            Text(
              "Scan the QR Code above and contact with \nyour nearby clients in a secure way",
              style: TextStyle(fontWeight: FontWeight.w200, fontSize: 12),
            ),
            SizedBox(height: 30),
            Row(
              children: <Widget>[
                Expanded(
                  child: Divider(
                    indent: 30,
                    endIndent: 10,
                    thickness: 1,
                    color: Colors.black38,
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Text(
                  'OR',
                  style: textStyle.copyWith(fontSize: 14),
                ),
                Expanded(
                  child: Divider(
                    endIndent: 30,
                    indent: 10,
                    thickness: 1,
                    color: Colors.black38,
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 30),
              width: double.infinity,
              child: FlatButton(
                padding: EdgeInsets.symmetric(vertical: 20),
                onPressed: () {
                  setState(() {
                    scanResults();
                  });
                },
                color: Colors.lightBlueAccent,
                child: Text(
                  "Scan and Share",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
