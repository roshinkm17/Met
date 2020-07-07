import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';

class Scanner extends StatefulWidget {
  static String id = "scanner_id";

  @override
  _ScannerState createState() => _ScannerState();
}

class _ScannerState extends State<Scanner> {
  void initState() {
    super.initState();
    scanner();
  }

  scanner() async {
    var result = await BarcodeScanner.scan();
    setState(() {
      resultText = result.rawContent == null ? "Scan first" : result.rawContent;
    });
  }

  String resultText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Center(
            child: Text("$resultText"),
          ),
        ),
      ),
    );
  }
}
