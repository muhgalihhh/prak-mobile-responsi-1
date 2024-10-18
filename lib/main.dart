import 'package:aplikasimanajemenbuku/helpers/user_info.dart';
import 'package:aplikasimanajemenbuku/ui/buku_page.dart';
import 'package:aplikasimanajemenbuku/ui/login_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget page = const CircularProgressIndicator();
  @override
  void initState() {
    super.initState();
    isLogin();
  }

  void isLogin() async {
    var token = await UserInfo().getToken();
    if (token != null) {
      setState(() {
        page = const BukuPage();
      });
    } else {
      setState(() {
        page = const LoginPage();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi Manajemen Keuangan',
      debugShowCheckedModeBanner: false,
      home: page,
      theme: ThemeData(
        fontFamily: 'Times New Roman',
      ),
    );
  }
}
