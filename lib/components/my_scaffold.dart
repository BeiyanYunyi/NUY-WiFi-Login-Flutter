import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:wifilogin/api/get_ip.dart';
import 'package:wifilogin/api/login.dart';
import 'package:wifilogin/components/my_navigation_bar.dart';
import 'package:wifilogin/data/location.dart';
import 'package:wifilogin/data/login_form_data.dart';
import 'package:wifilogin/pages/my_home_page.dart';

import '../pages/info_page.dart';

class MyScaffold extends StatelessWidget {
  const MyScaffold({super.key});
  static const platform = MethodChannel('club.penclub.wifilogin/default');

  @override
  Widget build(BuildContext context) {
    final LoginFormData c = Get.find();
    final LocationData loc = Get.find();
    getIP().then((value) {
      c.ip.value = value.data;
      c.loading.value = false;
    }).catchError((e) {
      log(e.toString());
    });
    c.load();

    return Obx(() => Scaffold(
          appBar: AppBar(
            title: Obx(() => Text(loc.title.value)),
            elevation: 4,
          ),
          body: loc.loc.value == 0 ? const MyHomePage() : const InfoPage(),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: const MyNavigationBar(),
          floatingActionButton: loc.loc.value == 0
              ? FloatingActionButton(
                  onPressed: c.loading.value
                      ? null
                      : () {
                          login(form: c, ip: c.ip.value)
                              .then((res) => {
                                    Get.snackbar("登录成功", res.message,
                                        duration: const Duration(seconds: 1)),
                                    if (defaultTargetPlatform ==
                                        TargetPlatform.android)
                                      {
                                        platform.invokeMethod(
                                            "reportCaptivePortalDismissed")
                                      }
                                  })
                              .then((res) => c.save())
                              .catchError((err) => {
                                    log(err.toString(), level: 4),
                                    Get.snackbar(
                                        "登录失败",
                                        (err as Exception)
                                            .toString()
                                            .replaceFirst('Exception: ', '')),
                                  });
                        },
                  tooltip: '登录',
                  child: Obx(() => c.loading.value
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : const Icon(Icons.send)),
                )
              : null, // This trailing comma makes auto-formatting nicer for build methods.
        ));
  }
}
