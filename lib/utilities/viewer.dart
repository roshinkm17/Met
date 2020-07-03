import 'package:flutter/material.dart';
import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

class Viewer extends StatefulWidget {
  Viewer(this.fileUrl);
  final fileUrl;
  static String id = "viewer_id";
  @override
  _ViewerState createState() => _ViewerState();
}

class _ViewerState extends State<Viewer> {
  @override
  void initState() {
    super.initState();
    setState(() {
      pdfUrl = widget.fileUrl;
    });
    initialize();
  }

  initialize() async {
    setState(() {
      _isLoading = true;
    });
    final doc = await PDFDocument.fromURL(pdfUrl);
    setState(() {
      _isLoading = false;
      _document = doc;
    });
  }

  String pdfUrl;
  bool _isLoading = false;
  String pdfAsset = "http://www.africau.edu/images/default/sample.pdf";
  PDFDocument _document;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My document"),
      ),
      body: Center(
        child: Container(
          child: _isLoading
              ? CircularProgressIndicator()
              : PDFViewer(
                  document: _document,
                  indicatorBackground: Colors.red,
                  showPicker: false,
                ),
        ),
      ),
    );
  }
}
