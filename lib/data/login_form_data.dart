import 'package:flutter/material.dart';

enum ISP { cmcc, chinaNet, chinaUnicom, nuist }

class LoginFormData extends ChangeNotifier {
  String username;
  String password;
  ISP isp;
  LoginFormData(
      {required this.username, required this.password, required this.isp});

  void setUsername(String username) {
    this.username = username;
    notifyListeners();
  }

  void setPassword(String password) {
    this.password = password;
    notifyListeners();
  }

  void setISP(ISP isp) {
    this.isp = isp;
    notifyListeners();
  }
}
