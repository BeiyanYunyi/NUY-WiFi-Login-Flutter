import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum ISP { cmcc, chinaNet, chinaUnicom, nuy }

class LoginFormData extends GetxController {
  var username = ''.obs;
  var password = ''.obs;
  var ip = ''.obs;
  var loading = true.obs;
  var isp = ISP.cmcc.obs;
  LoginFormData();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  Future<void> save() async {
    final prefs = await SharedPreferences.getInstance();
    await Future.wait([
      prefs.setString('username', username.value),
      prefs.setString('password', password.value),
      prefs.setInt('isp', isp.value.index)
    ]);
  }

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    var usernameRes = prefs.getString('username') ?? '';
    var passwordRes = prefs.getString('password') ?? '';
    usernameController.text = usernameRes;
    passwordController.text = passwordRes;
    username.value = usernameRes;
    password.value = passwordRes;
    isp.value = ISP.values[prefs.getInt('isp') ?? 0];
  }
}
