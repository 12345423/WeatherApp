// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:modul3/login.dart';
import 'package:modul3/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  String nama = "";
  String nim = "";
  //ambil data nama dari sharedpreference
  _ambilData() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString("token") != null) {
      setState(() {
        nama = prefs.getString('name')!;
      });
    }
  }

//fungsi logout dengan menghapus data yang ada di sharedpreference
//dan mengubah nilai isLoggedIn menjadi false
//lalu diarahkan ke halaman login
  _logout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return Login();
    }));
  }

  @override
  void initState() {
    _ambilData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //list buat menu di halaman account
    List<Map<String, dynamic>> list = [
      {"title": "Temperature units", "var": "C"},
      {"title": "Wind speed units", "var": "km/h"},
      {"title": "Atmospheric Units", "var": "mbar"},
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 19, 98, 218),
        elevation: 0.0,
        title: const Text(
          "Account Page",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        leading: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: InkWell(
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) {
                  return const HomePage();
                }));
              },
              child: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            )),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 250,
            decoration: BoxDecoration(
              color: Colors.blueAccent,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.person,
                    size: 50,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  nama,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: Colors.white),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  nim,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.white),
                ),
              ],
            ),
          ),
          ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: list.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(list[index]["title"]),
                  trailing: Text(list[index]["var"]),
                );
              }),
          SizedBox(
            height: 10,
          ),
          //tombol untuk logout
          ElevatedButton(
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.blueAccent)),
            onPressed: () {
              _logout();
            },
            child: Text("Logout"),
          ),
        ],
      ),
    );
  }
}
