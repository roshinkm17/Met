import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrDisplay extends StatefulWidget {
  static String id = "qr_display_screen";
  @override
  _State createState() => _State();
}

class _State extends State<QrDisplay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.all(20),
          child: QrImage(
            data: 'This is a random String!!!',
          ),
        ),
      ),
    );
  }
}
