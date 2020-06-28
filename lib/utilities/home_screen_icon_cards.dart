import 'package:flutter/material.dart';

class HomeScreenIconCard extends StatelessWidget {
  HomeScreenIconCard(this.icon, this.iconText);
  final String iconText;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: <Widget>[
          Icon(
            icon,
            size: 40,
            color: Colors.blueAccent,
          ),
          SizedBox(height: 20),
          Text(
            iconText,
            style: TextStyle(fontWeight: FontWeight.w300, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
