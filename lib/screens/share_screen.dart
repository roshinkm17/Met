import 'package:flutter/material.dart';
import 'package:met/constants.dart';
import 'package:met/screens/qr_scanning_screen.dart';
import 'package:met/utilities/qr_code_generator.dart';

class ShareScreen extends StatefulWidget {
  ShareScreen({Key key}) : super(key: key);
  static String id = 'share_screen_page_id';

  @override
  _ShareScreenState createState() => _ShareScreenState();
}

class _ShareScreenState extends State<ShareScreen> {
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
              width: deviceWidth * 0.5,
              padding: EdgeInsets.all(20),
              child: QRCode(),
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
                  Navigator.pushNamed(context, Scanner.id);
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
