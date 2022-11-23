import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

class Form extends StatefulWidget {
  const Form({super.key});

  @override
  State<Form> createState() => _FormState();
}

class _FormState extends State<Form> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginFormData>(
        create: (_) => LoginFormData(username: '', password: '', isp: ISP.cmcc),
        child: Consumer<LoginFormData>(
            builder: (context, formData, child) => Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(formData.password),
                    TextField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: '用户名',
                      ),
                      onChanged: (value) => formData.setUsername(value),
                    ),
                    TextField(
                      obscureText: true,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: '密码',
                      ),
                      onChanged: (value) => formData.setPassword(value),
                    ),
                  ],
                )));
  }
}
