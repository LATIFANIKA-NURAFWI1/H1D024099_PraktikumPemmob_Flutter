import 'dart:convert';
import 'package:flutter1/helpers/api.dart';
import 'package:flutter1/helpers/api_url.dart';
import 'package:flutter1/model/login.dart';

class LoginBloc {
  static Future<Login> login({String? email, String? password}) async {
    String apiUrl = ApiUrl.login;

    var body = {
      "email": email,
      "password": password,
    };

    var response = await Api().post(apiUrl, body);
    var jsonObj = response is String ? json.decode(response) : response;
    return Login.fromJson(jsonObj as Map<String, dynamic>);
  }
}
