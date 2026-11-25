import 'dart:convert';
import 'package:flutter1/helpers/api.dart';
import 'package:flutter1/helpers/api_url.dart';
import 'package:flutter1/model/registrasi.dart';

class RegistrasiBloc {
  static Future<Registrasi> registrasi({
    String? nama,
    String? email,
    String? password,
  }) async {
    String apiUrl = ApiUrl.registrasi;

    var body = {
      "nama": nama,
      "email": email,
      "password": password,
    };

    var response = await Api().post(apiUrl, body);
    var jsonObj = response is String ? json.decode(response) : response;
    return Registrasi.fromJson(jsonObj as Map<String, dynamic>);
  }
}
