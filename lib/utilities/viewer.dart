import 'package:flutter/material.dart';
import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';
import 'package:met/utilities/document_property.dart';

class Viewer extends StatefulWidget {
  Viewer(this.docProperty);
  final DocProperty docProperty;
  static String id = "viewer_id";
  @override
  _ViewerState createState() => _ViewerState();
}

class _ViewerState extends State<Viewer> {
  @override
  void initState() {
    super.initState();
    setState(() {
      _docProperty.docURL = widget.docProperty.docURL;
      _docProperty.docName = widget.docProperty.docName;
      _docProperty.docExtension = widget.docProperty.docExtension;
    });
    initialize();
  }

  initialize() async {
    setState(() {
      _isLoading = true;
    });
    final doc = await PDFDocument.fromURL(_docProperty.docURL);
    setState(() {
      _isLoading = false;
      _document = doc;
    });
  }

  DocProperty _docProperty = DocProperty();
  String pdfUrl;
  bool _isLoading = false;
  PDFDocument _document;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_docProperty.docName),
      ),
      body: Center(
        child: Container(
          child: _docProperty.docExtension == "pdf"
              ? (_isLoading
                  ? CircularProgressIndicator()
                  : PDFViewer(
                      document: _document,
                      indicatorBackground: Colors.red,
                      showPicker: false,
                    ))
              : Expanded(
                  child: Image(
                    fit: BoxFit.contain,
                    image: NetworkImage(_docProperty.docURL),
                  ),
                ),
        ),
      ),
    );
  }
}
