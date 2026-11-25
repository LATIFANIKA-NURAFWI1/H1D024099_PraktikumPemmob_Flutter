import 'package:flutter1/helpers/user_info.dart';

class LogoutBloc {
  static Future<void> logout() async {
    await UserInfo().logout();
  }
}
