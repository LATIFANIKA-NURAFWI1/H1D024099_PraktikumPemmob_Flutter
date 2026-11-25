import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter1/helpers/app_exception.dart';
import 'package:flutter1/helpers/user_info.dart';

class Api {
  Future<dynamic> post(dynamic url, dynamic data) async {
    final String? token = await UserInfo().getToken();
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      if (token != null && token.isNotEmpty) 'Authorization': 'Bearer $token',
    };

    try {
      final response = await http.post(
        Uri.parse(url.toString()),
        body: jsonEncode(data),
        headers: headers,
      );
      return _returnResponse(response);
    } catch (e) {
      if (e is AppException) rethrow;
      throw FetchDataException('Gagal terhubung ke server: ${e.toString()}');
    }
  }

  Future<dynamic> get(dynamic url) async {
    final String? token = await UserInfo().getToken();
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      if (token != null && token.isNotEmpty) 'Authorization': 'Bearer $token',
    };

    try {
      final response = await http.get(
        Uri.parse(url.toString()),
        headers: headers,
      );
      return _returnResponse(response);
    } catch (e) {
      if (e is AppException) rethrow;
      throw FetchDataException('Gagal terhubung ke server: ${e.toString()}');
    }
  }

  Future<dynamic> put(dynamic url, dynamic data) async {
    final String? token = await UserInfo().getToken();
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      if (token != null && token.isNotEmpty) 'Authorization': 'Bearer $token',
    };

    try {
      final response = await http.put(
        Uri.parse(url.toString()),
        body: jsonEncode(data),
        headers: headers,
      );
      return _returnResponse(response);
    } catch (e) {
      if (e is AppException) rethrow;
      throw FetchDataException('Gagal terhubung ke server: ${e.toString()}');
    }
  }

  Future<dynamic> delete(dynamic url) async {
    final String? token = await UserInfo().getToken();
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      if (token != null && token.isNotEmpty) 'Authorization': 'Bearer $token',
    };

    try {
      final response = await http.delete(
        Uri.parse(url.toString()),
        headers: headers,
      );
      return _returnResponse(response);
    } catch (e) {
      if (e is AppException) rethrow;
      throw FetchDataException('Gagal terhubung ke server: ${e.toString()}');
    }
  }

  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        return json.decode(response.body);
      case 400:
        throw BadRequestException(response.body);
      case 401:
      case 403:
        throw UnauthorisedException(response.body);
      case 422:
        throw InvalidInputException(response.body);
      case 500:
      default:
        throw FetchDataException(
          'Error server dengan status code: ${response.statusCode}',
        );
    }
  }
}
