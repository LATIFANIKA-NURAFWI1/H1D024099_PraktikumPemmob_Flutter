import 'package:flutter/material.dart';
import 'package:flutter1/about_page.dart';
import 'package:flutter1/column_widget.dart';
import 'package:flutter1/hello_world.dart';
import 'package:flutter1/helpers/user_info.dart';
import 'package:flutter1/home_page.dart';
import 'package:flutter1/login_page.dart' as modul3_login;
import 'package:flutter1/model/produk.dart';
import 'package:flutter1/row_widget.dart';
import 'package:flutter1/ui/login_page.dart';
import 'package:flutter1/ui/produk_detail.dart';
import 'package:flutter1/ui/produk_form.dart';
import 'package:flutter1/ui/produk_page.dart';
import 'package:flutter1/ui/registrasi_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget _page = const CircularProgressIndicator();

  @override
  void initState() {
    super.initState();
    isLogin();
  }

  void isLogin() async {
    var token = await UserInfo().getToken();
    if (token != null && token.isNotEmpty) {
      setState(() {
        _page = const ProdukPage();
      });
    } else {
      setState(() {
        _page = const LoginPage();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Toko Kita',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: false,
        primarySwatch: Colors.blue,
      ),
      home: _page,
      routes: {
        '/login': (context) => const LoginPage(),
        '/registrasi': (context) => const RegistrasiPage(),
        '/produk': (context) => const ProdukPage(),
        '/produk-form': (context) => const ProdukForm(),
        '/produk-detail': (context) => ProdukDetail(
              produk: Produk(
                id: 1,
                kodeProduk: 'A001',
                namaProduk: 'Kamera',
                hargaProduk: 5000000,
              ),
            ),
        '/modul3-login': (context) => const modul3_login.LoginPage(),
        '/home': (context) => const HomePage(),
        '/about': (context) => const AboutPage(),
        '/hello-world': (context) => const HelloWorld(),
        '/column-widget': (context) => const ColumnWidget(),
        '/row-widget': (context) => const RowWidget(),
      },
    );
  }
}
