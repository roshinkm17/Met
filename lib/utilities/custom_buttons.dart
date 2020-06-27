import 'package:flutter/material.dart';

class SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black87,
      decoration: BoxDecoration(),
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: RawMaterialButton(
        onPressed: null,
        child: Text(
          "Sign Up",
          style: TextStyle(
            fontSize: 30,
            color: Colors.deepOrangeAccent,
          ),
        ),
      ),
    );
  }
}
