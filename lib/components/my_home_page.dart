import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:wifilogin/api/get_ip.dart';
import 'package:wifilogin/api/login.dart';
import 'package:wifilogin/components/form.dart' as app_form;
import 'package:wifilogin/data/consts.dart';
import 'package:wifilogin/data/login_form_data.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;
  static const platform = MethodChannel('club.penclub.wifilogin/default');

  @override
  Widget build(BuildContext context) {
    final LoginFormData c = Get.find();
    getIP().then((value) => c.ip.value = value.data);
    c.load();
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(title),
        elevation: 4,
      ),
      body: Scrollbar(
          child: Center(
              child: SingleChildScrollView(
        primary: true,
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
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
      ))),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.send), label: '登录'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: '盒'),
        ],
        currentIndex: Get.currentRoute == '/' ? 0 : 1,
        onTap: (value) => Get.toNamed(value == 0 ? '/' : '/my'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          login(form: c, ip: c.ip.value)
              .then((res) => {
                    Get.snackbar("登录成功", res.message),
                    platform.invokeMethod("reportCaptivePortalDismissed")
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
        tooltip: 'Increment',
        child: const Icon(Icons.send),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
