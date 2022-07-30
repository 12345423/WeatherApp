// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

Widget currentWeather(IconData icon, String temp, String location) {
  return Center(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 80.0),
        Icon(
          icon,
          color: Colors.orange,
          size: 100.0,
        ),
        SizedBox(
          height: 20.0,
        ),
        Text(
          temp,
          style: TextStyle(
            fontSize: 50.0,
          ),
        ),
        SizedBox(height: 20.0),
        Text(
          location,
          style: TextStyle(
            fontSize: 18.0,
            color: Color(0xFF5a5a5a),
          ),
        ),
      ],
    ),
  );
}
