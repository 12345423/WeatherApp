// ignore_for_file: prefer_const_constructors

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:modul3/main.dart';
import 'package:modul3/model_auth.dart';
import 'package:modul3/network/api/auth/auth.dart';
import 'package:modul3/network/dio_client.dart';
import 'package:modul3/register.dart';
import 'package:modul3/repo/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 280,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                image: DecorationImage(
                    image: AssetImage("image/sky.jpg"), fit: BoxFit.cover),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Login",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            const SizedBox(
              height: 20,
            ),
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    TextFormField(
                      controller: _email,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Email',
                          prefixIcon: Icon(Icons.person)),
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return 'Username tidak boleh kosong!';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _password,
                      textInputAction: TextInputAction.done,
                      obscureText: true,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                          prefixIcon: Icon(Icons.password)),
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return 'Password tidak boleh kosong!';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () async {
                            Dio dio = Dio();
                            DioClient dioClient = DioClient(dio);
                            AuthApi authApi = AuthApi(dioClient: dioClient);
                            AuthRepository repo =
                                AuthRepository(authApi: authApi);

                            try {
                              ModelAuth logins = await repo.loginReq(
                                  _email.text, _password.text);
                              String getName =
                                  await repo.meReq(logins.access_token);
                              final prefs =
                                  await SharedPreferences.getInstance();
                              prefs.setString("token", logins.access_token);
                              prefs.setString("name", getName);
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      const HomePage(),
                                ),
                                (route) => false,
                              );
                            } catch (e) {
                              const snackBar = SnackBar(
                                  content:
                                      Text("Username atau password salah!!"));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }
                          },
                          child: const Text("Login")),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const RegisterPage(),
                          ),
                        );
                      },
                      child: const Text(
                        "Belum punya akun? Register!",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
