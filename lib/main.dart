import 'package:flutter/material.dart';
import 'package:flutter1/about_page.dart';
import 'package:flutter1/column_widget.dart';
import 'package:flutter1/hello_world.dart';
import 'package:flutter1/home_page.dart';
import 'package:flutter1/login_page.dart';
import 'package:flutter1/row_widget.dart';
import 'package:flutter1/ui/produk_detail.dart';
import 'package:flutter1/ui/produk_form.dart';
import 'package:flutter1/ui/produk_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Menu',
      theme: ThemeData(
        useMaterial3: false,
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginPage(),
        '/home': (context) => const HomePage(),
        '/about': (context) => const AboutPage(),
        '/produk': (context) => const ProdukPage(),
        '/produk-form': (context) => const ProdukForm(),
        '/produk-detail': (context) => const ProdukDetail(
              kodeProduk: 'P001',
              namaProduk: 'Kulkas',
              hargaProduk: 2500000,
            ),
        '/hello-world': (context) => const HelloWorld(),
        '/column-widget': (context) => const ColumnWidget(),
        '/row-widget': (context) => const RowWidget(),
      },
    );
  }
}
