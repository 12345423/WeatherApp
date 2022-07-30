// ignore_for_file: prefer_const_constructors, deprecated_member_use

import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:modul3/addposition.dart';
import 'package:modul3/detailspage.dart';
import 'package:modul3/firebase_options.dart';
import 'package:modul3/login.dart';
import 'package:modul3/network/api/tempat/tempat.dart';
import 'package:modul3/network/dio_client.dart';
import 'package:modul3/repo/tempat.dart';
import 'package:modul3/servicepage.dart';
import 'package:modul3/tempat.dart';
import 'package:modul3/tempat_provider.dart';
import 'package:modul3/views/additional_information.dart';
import 'package:modul3/views/current_weather.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'BNBCustom.dart';
import 'accountpage.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(ChangeNotifierProvider<TempatProvider>(
      create: ((context) => TempatProvider()), child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool login = false;

  startNotification() async {
    final fcm = FirebaseMessaging.instance;

    try {
      if (Platform.isIOS) {
        await fcm.requestPermission(
          alert: true,
          badge: true,
          sound: true,
        );

        await fcm.setForegroundNotificationPresentationOptions(
          alert: true,
          badge: true,
          sound: true,
        );
      }
      //baris ini digunakan untuk generate token untuk tes notifikasi di firebase
      debugPrint(
          "Token ${(await FirebaseMessaging.instance.getToken()).toString()}");

      //baris ini digunakan untuk menampilkan notifikasi ketika aplikasi sedang berjalan
      //tapi ketika app sedang berjalan, tidak ada notif kaya pesan whatsapp masuk
      //jadi ngeceknya bisa lewat debug console saja
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        RemoteNotification? notification = message.notification;
        debugPrint("Judul pesan foreground : ${notification!.title}");
        debugPrint("Isi pesan foreground : ${notification.body}");
      });

      //baris ini digunakan untuk menampilkan notifikasi setelah aplikasi dibuka lagi
      //setelah aplikasi ditutup, terutama ketika aplikasi terminated
      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        RemoteNotification? notification = message.notification;
        debugPrint("onMessageOpenendApp title : ${notification!.title}");
        debugPrint("onMessageOpenendApp body : ${notification.body}");
      });

      //baris ini digunakan untuk menampilkan notifikasi ketika aplikasi berjalan
      //di background. misal kita keluar app, nanti bakal muncul notif diatas
      //seperti pesan whatsapp masuk
      FirebaseMessaging.onBackgroundMessage((RemoteMessage message) async {
        RemoteNotification? notification = message.notification;
        debugPrint("Judul pesan background : ${notification!.title}");
        debugPrint("Isi pesan background : ${notification.body}");
      });

      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

//fungsi buat ngecek sudah login atau belum
  _checkLoggedIn() async {
    //fungsi ini digunakan untuk mengambil data dari user yang login
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString("token") != null) {
      setState(() {
        login = true;
      });
    } else {
      setState(() {
        login = false;
      });
    }
  }

  @override
  void initState() {
    //memanggil fungsi cek login diawal halaman dijalankan
    _checkLoggedIn();
    startNotification();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //jika login = true, maka diarahkan ke halaman utama
      //jika login = false, maka diarahkan ke halaman login
      home: login ? HomePage() : Login(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int current = 0;

  Future<List<Tempat>> ReadJsonData() async {
    final prefs = await SharedPreferences.getInstance();
    Dio dio = Dio();
    DioClient dioClient = DioClient(dio);
    TempatApi tempatApi = TempatApi(dioClient: dioClient);
    TempatRepository tempatRepository = TempatRepository(tempatApi: tempatApi);

    return tempatRepository.getAllTempatReq(prefs.getString("token")!);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: SizedBox(
        width: size.width,
        height: 80,
        child: Stack(
          children: [
            CustomPaint(
              size: Size(size.width, 80),
              painter: BNBCustom(),
            ),
            Center(
              heightFactor: 0.6,
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) {
                    return AccountPage();
                  }));
                },
                backgroundColor: Colors.orange,
                child: Icon(Icons.account_circle),
              ),
            ),
            SizedBox(
              width: size.width,
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: Icon(Icons.details),
                    color: Colors.orange,
                    onPressed: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) {
                        return ServicePage();
                      }));
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.add_location_alt),
                    color: Colors.orange,
                    onPressed: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) {
                        return AddPosition();
                      }));
                    },
                  ),
                  Container(
                    width: size.width * 0.20,
                  ),
                  IconButton(
                    icon: Icon(Icons.settings),
                    color: Colors.orange,
                    onPressed: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) {
                        return DetailsPage();
                      }));
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.cloud),
                    color: Colors.orange,
                    onPressed: () {},
                  )
                ],
              ),
            )
          ],
        ),
      ),
      backgroundColor: Color.fromARGB(255, 249, 249, 249),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 19, 98, 218),
        elevation: 0.0,
        title: const Text(
          "Weather Forecast",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.menu),
          color: Color.fromARGB(255, 0, 0, 0),
        ),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder<List<Tempat>>(
            future: ReadJsonData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                final error = snapshot.error;
                return Center(
                  child: Text(
                    "Error: " + error.toString(),
                  ),
                );
              } else if (snapshot.hasData) {
                if (snapshot.data!.isEmpty) {
                  return Center(
                    child: Text("Data kosong!!"),
                  );
                }
                context.read<TempatProvider>().data = snapshot.data!;

                Tempat tempat =
                    context.watch<TempatProvider>().getCurrent(current);
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //
                    currentWeather(Icons.wb_sunny_rounded,
                        "${tempat.temperature}°", tempat.tempat),
                    SizedBox(
                      height: 20.0,
                    ),

                    SizedBox(
                      height: 20.0,
                    ),
                    RaisedButton(
                      color: Colors.black,
                      child: Text(
                        'Detail',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SecondPage(
                                    tempat: tempat,
                                  )),
                        );
                      },
                    ),
                    RaisedButton(
                      color: Colors.black,
                      child: Text(
                        'Update',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        String temperature = Random().nextInt(38).toString();
                        final prefs = await SharedPreferences.getInstance();
                        Dio dio = Dio();
                        DioClient dioClient = DioClient(dio);
                        TempatApi tempatApi = TempatApi(dioClient: dioClient);
                        TempatRepository tempatRepository =
                            TempatRepository(tempatApi: tempatApi);
                        Tempat tempats = await tempatRepository.updateTempatReq(
                            tempat.id, temperature, prefs.getString("token")!);

                        context
                            .read<TempatProvider>()
                            .updateTempat(current, tempats);
                        context.read<TempatProvider>().data = snapshot.data!;

                        setState(() {
                          tempat = context
                              .read<TempatProvider>()
                              .getCurrent(current);
                        });
                      },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    RaisedButton(
                      color: Colors.black,
                      child: Text(
                        'Ganti Lokasi',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        setState(() {
                          if (context.read<TempatProvider>().data.length - 1 ==
                              current) {
                            current = 0;
                          } else {
                            current++;
                          }
                        });
                      },
                    ),
                    SizedBox(height: 135.0),
                  ],
                );
              }
              return Container();
            }),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  const SecondPage({Key? key, required this.tempat}) : super(key: key);
  final Tempat tempat;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Weather Forecast"),
        backgroundColor: Color.fromARGB(255, 19, 98, 218),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image(image: AssetImage('image/kotabatu.jpg')),
            SizedBox(height: 20.0),
            Text(
              tempat.tempat,
              style: TextStyle(
                fontSize: 30.0,
                color: Color(0xdd212121),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 18.0),
            Text(
              "Additional Information",
              style: TextStyle(
                fontSize: 24.0,
                color: Color(0xdd212121),
                fontWeight: FontWeight.bold,
              ),
            ),
            additionalInformation(
                tempat.wind,
                tempat.humidity,
                tempat.pressure,
                "${tempat.temperature}°",
                "${tempat.area} km²",
                tempat.population),
            RaisedButton(
              color: Colors.black,
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'Kembali',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
