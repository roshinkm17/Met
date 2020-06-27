import 'package:flutter/material.dart';

class SignInButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40, vertical: 5),
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.orangeAccent, Colors.deepOrange]),
        borderRadius: BorderRadius.circular(50),
      ),
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
      child: RawMaterialButton(
        onPressed: null,
        child: Text(
          "Sign In",
          style: TextStyle(
            fontWeight: FontWeight.w300,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40, vertical: 5),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        border: Border.all(
          color: Colors.deepOrangeAccent,
          width: 2,
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
      child: RawMaterialButton(
        onPressed: null,
        child: Text(
          "Sign Up",
          style: TextStyle(
            fontWeight: FontWeight.w300,
            fontSize: 20,
            color: Colors.deepOrange,
          ),
        ),
      ),
    );
  }
}
