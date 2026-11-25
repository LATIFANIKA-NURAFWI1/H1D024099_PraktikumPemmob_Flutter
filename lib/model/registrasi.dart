class Registrasi {
  int? code;
  bool? status;
  String? data;

  Registrasi({this.code, this.status, this.data});

  factory Registrasi.fromJson(Map<String, dynamic> obj) {
    return Registrasi(
      code: int.tryParse(obj['code']?.toString() ?? ''),
      status: obj['status'] is bool
          ? obj['status'] as bool
          : (obj['status']?.toString().toLowerCase() == 'true'),
      data: obj['data']?.toString(),
    );
  }
}
