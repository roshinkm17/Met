import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRCode extends StatelessWidget {
  QRCode({this.data});
  final String data;
  @override
  Widget build(BuildContext context) {
    return QrImage(
      data: data,
      errorCorrectionLevel: QrErrorCorrectLevel.Q,
      embeddedImageStyle: QrEmbeddedImageStyle(),
      foregroundColor: Colors.black54,
    );
    ;
  }
}
