// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:modul3/main.dart';

class ServicePage extends StatelessWidget {
  const ServicePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 19, 98, 218),
        elevation: 0.0,
        title: const Text(
          "Service Page",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        leading: Padding(
            padding: EdgeInsets.only(left: 10),
            child: InkWell(
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) {
                  return HomePage();
                }));
              },
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            )),
      ),
    );
  }
}
