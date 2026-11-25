class Login {
  int? code;
  bool? status;
  String? token;
  int? userID;
  String? userEmail;

  Login({this.code, this.status, this.token, this.userID, this.userEmail});

  factory Login.fromJson(Map<String, dynamic> obj) {
    final dynamic data = obj['data'];
    final Map<String, dynamic>? dataMap =
        data is Map<String, dynamic> ? data : null;
    final dynamic user = dataMap?['user'];
    final Map<String, dynamic>? userMap =
        user is Map<String, dynamic> ? user : null;

    return Login(
      code: int.tryParse(obj['code']?.toString() ?? ''),
      status: obj['status'] is bool
          ? obj['status'] as bool
          : (obj['status']?.toString().toLowerCase() == 'true'),
      token: dataMap?['token']?.toString(),
      userID: int.tryParse(userMap?['id']?.toString() ?? ''),
      userEmail: userMap?['email']?.toString(),
    );
  }
}
