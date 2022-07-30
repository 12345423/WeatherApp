// ignore_for_file: non_constant_identifier_names, prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

TextStyle titleFont =
    const TextStyle(fontWeight: FontWeight.w600, fontSize: 18.0);

TextStyle infoFont =
    const TextStyle(fontWeight: FontWeight.w400, fontSize: 18.0);
Widget additionalInformation(String wind, String humidity, String pressure,
    String feelsLike, String Luas, String Populasi) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(18.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Wind", style: infoFont),
                SizedBox(height: 18.0),
                Text(
                  "Pressure",
                  style: infoFont,
                ),
                SizedBox(height: 18.0),
                Text(
                  "Area",
                  style: infoFont,
                )
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(wind, style: infoFont),
                SizedBox(height: 18.0),
                Text(
                  pressure,
                  style: infoFont,
                ),
                SizedBox(height: 18.0),
                Text(
                  Luas,
                  style: infoFont,
                )
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Humidity", style: infoFont),
                SizedBox(height: 18.0),
                Text(
                  "Feels Like",
                  style: infoFont,
                ),
                SizedBox(height: 18.0),
                Text(
                  "Population",
                  style: infoFont,
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(humidity, style: infoFont),
                SizedBox(height: 18.0),
                Text(
                  feelsLike,
                  style: infoFont,
                ),
                SizedBox(height: 18.0),
                Text(
                  Populasi,
                  style: infoFont,
                )
              ],
            ),
          ],
        )
      ],
    ),
  );
}
