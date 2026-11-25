import 'dart:convert';
import 'package:flutter1/helpers/api.dart';
import 'package:flutter1/helpers/api_url.dart';
import 'package:flutter1/model/produk.dart';

class ProdukBloc {
  static Future<List<Produk>> getProduks() async {
    String apiUrl = ApiUrl.listProduk;
    var response = await Api().get(apiUrl);
    var jsonObj = response is String ? json.decode(response) : response;
    var data = (jsonObj as Map<String, dynamic>)['data'];
    List<Produk> produks = [];
    if (data is List) {
      for (var item in data) {
        if (item is Map<String, dynamic>) {
          produks.add(Produk.fromJson(item));
        }
      }
    }
    return produks;
  }

  static Future<bool> addProduk({Produk? produk}) async {
    String apiUrl = ApiUrl.createProduk;

    var body = {
      "kode_produk": produk?.kodeProduk,
      "nama_produk": produk?.namaProduk,
      "harga": produk?.hargaProduk?.toString(),
    };

    var response = await Api().post(apiUrl, body);
    var jsonObj = response is String ? json.decode(response) : response;
    return (jsonObj as Map<String, dynamic>)['status'] == true;
  }

  static Future<bool> updateProduk({required Produk produk}) async {
    String apiUrl = ApiUrl.updateProduk(produk.id!);

    var body = {
      "kode_produk": produk.kodeProduk,
      "nama_produk": produk.namaProduk,
      "harga": produk.hargaProduk?.toString(),
    };

    var response = await Api().put(apiUrl, body);
    var jsonObj = response is String ? json.decode(response) : response;
    return (jsonObj as Map<String, dynamic>)['status'] == true;
  }

  static Future<bool> deleteProduk({int? id}) async {
    String apiUrl = ApiUrl.deleteProduk(id!);

    var response = await Api().delete(apiUrl);
    var jsonObj = response is String ? json.decode(response) : response;
    if (jsonObj is Map<String, dynamic>) {
      return jsonObj['status'] == true || jsonObj['data'] == true;
    }
    return false;
  }
}
