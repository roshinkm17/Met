import 'package:flutter/material.dart';

class SignInButton extends StatelessWidget {
  SignInButton(this.onPressed);
  final Function onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40, vertical: 5),
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xffFF512F), Color(0xffF44C4C)]),
        borderRadius: BorderRadius.circular(50),
      ),
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 0),
      child: RawMaterialButton(
        onPressed: onPressed,
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
  SignUpButton(this.onPressed);
  final Function onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40, vertical: 5),
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xffF44C4C)),
        borderRadius: BorderRadius.circular(50),
      ),
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 0),
      child: RawMaterialButton(
        onPressed: onPressed,
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
