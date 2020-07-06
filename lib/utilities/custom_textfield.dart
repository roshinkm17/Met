import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField(this.labelText, this.returnValue);
  final String labelText;
  var returnValue;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40),
      child: TextField(
        onChanged: (value) {},
        keyboardType: labelText == 'Email' ? TextInputType.emailAddress : TextInputType.text,
        obscureText: labelText == "Password" ? true : false,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(fontSize: 16, color: Colors.black54),
          contentPadding: EdgeInsets.only(left: 30),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black45),
            borderRadius: BorderRadius.circular(50),
          ),
        ),
      ),
    );
  }
}
