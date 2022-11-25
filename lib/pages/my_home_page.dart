import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wifilogin/components/form.dart' as app_form;
import 'package:wifilogin/data/consts.dart';
import 'package:wifilogin/data/login_form_data.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginFormData c = Get.find();
    return Scrollbar(
        child: Center(
            child: SingleChildScrollView(
      primary: true,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Obx(() => Text(
                '你的 IP：${c.ip}',
                style: Theme.of(context).textTheme.headline4,
              )),
          Container(
              margin: const EdgeInsets.all(appMargin),
              child: const app_form.Form()),
        ],
      ),
    )));
  }
}
