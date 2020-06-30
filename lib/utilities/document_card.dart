import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DocumentCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        padding: EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "pdf",
              style: TextStyle(color: Colors.orange),
            ),
            SizedBox(height: 20),
            Text(
              "Aadhar",
              style: TextStyle(color: Color(0xffABABAB)),
            ),
            SizedBox(height: 20),
            RaisedButton(
              elevation: 0,
              color: Color(0xff4caf50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              onPressed: () {
                print("hello");
              },
              child: Text(
                "view",
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
