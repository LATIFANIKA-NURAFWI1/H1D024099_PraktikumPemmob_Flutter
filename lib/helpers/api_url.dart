import 'package:flutter/foundation.dart';

class ApiUrl {
  // Base URL otomatis mendeteksi platform:
  // - Browser (Chrome / Flutter Web): menggunakan localhost
  // - Android Emulator: menggunakan 10.0.2.2
  // - Real Device (HP Fisik): ganti ke IP Wi-Fi laptop (misal: 'http://192.168.1.10/toko-api/public/index.php')
  static String baseUrl = kIsWeb
      ? 'http://localhost/toko-api/public/index.php'
      : 'http://10.0.2.2/toko-api/public/index.php';

  static String get registrasi => '$baseUrl/registrasi';
  static String get login => '$baseUrl/login';
  static String get listProduk => '$baseUrl/produk';
  static String get createProduk => '$baseUrl/produk';

  static String updateProduk(int id) {
    return '$baseUrl/produk/$id';
  }

  static String showProduk(int id) {
    return '$baseUrl/produk/$id';
  }

  static String deleteProduk(int id) {
    return '$baseUrl/produk/$id';
  }
}
