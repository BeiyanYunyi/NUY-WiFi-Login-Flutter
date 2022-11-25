import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wifilogin/api/get_ip.dart';
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
          Obx(() => c.ip.value != ''
              ? Text(
                  '你的 IP：${c.ip}',
                  style: Theme.of(context).textTheme.headline4,
                )
              : const SizedBox()),
          Container(
              margin: const EdgeInsets.all(appMargin),
              child: Obx(() => c.ip.value != ''
                  ? const app_form.Form()
                  : const LoadingIndicator())),
        ],
      ),
    )));
  }
}

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LoginFormData c = Get.find();
    var loading = false.obs;
    return Column(children: [
      const CircularProgressIndicator(),
      Container(
          margin: const EdgeInsets.only(top: appMargin),
          child: const Text("如果加载时间过长")),
      Container(
        margin: const EdgeInsets.only(top: appMargin),
        child: const Text("请检查是否已连接上 i-NUY"),
      ),
      Obx(() => IconButton(
          onPressed: loading.value
              ? null
              : () => {
                    loading.value = true,
                    getIP().then((value) => c.ip.value = value.data).catchError(
                        (e) {
                      log(e.toString());
                      return Future<String>.error(e.toString());
                    }).whenComplete(
                        () => {loading.value = false, c.loading.value = false})
                  },
          icon: const Icon(Icons.refresh)))
    ]);
  }
}
