import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:modul3/network/api/tempat/tempat.dart';
import 'package:modul3/network/dio_client.dart';
import 'package:modul3/repo/tempat.dart';
import 'package:modul3/tempat.dart';
import 'package:modul3/tempat_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TambahTempatPage extends StatefulWidget {
  const TambahTempatPage({Key? key}) : super(key: key);

  @override
  State<TambahTempatPage> createState() => _TambahTempatPageState();
}

class _TambahTempatPageState extends State<TambahTempatPage> {
  TextEditingController tempatController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController populationController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 19, 98, 218),
        elevation: 0.0,
        title: const Text(
          "Tambah Tempat",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        leading: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            )),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  hintText: "Tempat",
                ),
                controller: tempatController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: "Area",
                ),
                controller: areaController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: "Population",
                ),
                controller: populationController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      String wind = Random().nextInt(30).toString();
                      String pressure = Random().nextInt(1500).toString();
                      String humidty = Random().nextInt(10).toString();
                      String temperature = Random().nextInt(38).toString();
                      final prefs = await SharedPreferences.getInstance();
                      Dio dio = Dio();
                      DioClient dioClient = DioClient(dio);
                      TempatApi tempatApi = TempatApi(dioClient: dioClient);
                      TempatRepository tempatRepository =
                          TempatRepository(tempatApi: tempatApi);
                      Tempat tempats = await tempatRepository.createTempatReq(
                          tempatController.text,
                          wind,
                          pressure,
                          areaController.text,
                          humidty,
                          temperature,
                          populationController.text,
                          prefs.getString("token")!);
                      context.read<TempatProvider>().addTempat(tempats);
                      const snackBar = SnackBar(
                        content: Text('Data berhasil ditambah!'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      Navigator.pop(context);
                    }
                  },
                  child: const Text("Tambah"))
            ],
          ),
        ),
      ),
    );
  }
}
