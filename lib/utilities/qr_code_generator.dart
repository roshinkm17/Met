import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRCode extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return QrImage(
      data: "This is a sample QR Code.",
      errorCorrectionLevel: QrErrorCorrectLevel.Q,
      embeddedImage: NetworkImage(
          'https://img.icons8.com/ios-filled/50/000000/user-male-circle.png'),
      embeddedImageStyle: QrEmbeddedImageStyle(),
      foregroundColor: Colors.black54,
    );
  }
}
