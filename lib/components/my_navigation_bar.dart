import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wifilogin/data/location.dart';

class MyNavigationBar extends StatelessWidget {
  const MyNavigationBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LocationData loc = Get.find();
    return Obx(() => NavigationBar(
          destinations: const <Widget>[
            NavigationDestination(icon: Icon(Icons.home), label: '主页'),
            NavigationDestination(icon: Icon(Icons.person), label: '关于'),
          ],
          selectedIndex: loc.loc.value,
          onDestinationSelected: (value) => {
            loc.loc.value = value,
            loc.title.value = value == 0 ? '元带 WiFi' : '关于'
          },
        ));
  }
}
