// ignore_for_file: prefer_const_constructors

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:modul3/main.dart';
import 'package:modul3/network/api/tempat/tempat.dart';
import 'package:modul3/network/dio_client.dart';
import 'package:modul3/repo/tempat.dart';
import 'package:modul3/tambah_tempat.dart';
import 'package:modul3/tempat.dart';
import 'package:modul3/tempat_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddPosition extends StatelessWidget {
  const AddPosition({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Tempat> list = context.watch<TempatProvider>().data;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => TambahTempatPage()));
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 19, 98, 218),
        elevation: 0.0,
        title: const Text(
          "Add Position",
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
      body: ListView.builder(
          itemCount: list.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
                trailing: GestureDetector(
                    onTap: (() {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Peringatan!'),
                            content: SingleChildScrollView(
                              child: ListBody(
                                children: const <Widget>[
                                  Text('Yakin mau menghapus'),
                                ],
                              ),
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('Cancel'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                child: const Text('Hapus'),
                                onPressed: () async {
                                  final prefs =
                                      await SharedPreferences.getInstance();
                                  Dio dio = Dio();
                                  DioClient dioClient = DioClient(dio);
                                  TempatApi tempatApi =
                                      TempatApi(dioClient: dioClient);
                                  TempatRepository tempatRepository =
                                      TempatRepository(tempatApi: tempatApi);
                                  await tempatRepository.deleteTempatReq(
                                      list[index].id,
                                      prefs.getString("token")!);
                                  const snackBar = SnackBar(
                                    content: Text('Data berhasil dihapus!'),
                                  );

// Find the ScaffoldMessenger in the widget tree
// and use it to show a SnackBar.
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                  context
                                      .read<TempatProvider>()
                                      .deleteTempat(index);

                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          );
                        },
                      );
                    }),
                    child: Icon(Icons.delete)),
                title: Text(list[index].tempat));
          }),
    );
  }
}
