import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wifilogin/components/my_scaffold.dart';
import 'package:wifilogin/data/location.dart';
import 'package:wifilogin/data/login_form_data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.put(LoginFormData());
    Get.put(LocationData());
    return GetMaterialApp(
      title: '元带 WiFi',
      transitionDuration: const Duration(milliseconds: 200),
      theme: ThemeData(
        fontFamily: defaultTargetPlatform == TargetPlatform.windows
            ? 'Microsoft YaHei UI'
            : null,
        primarySwatch: Colors.teal,
        useMaterial3: true,
        // colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)),
      ),
      darkTheme: ThemeData.dark(useMaterial3: true),
      home: const MyScaffold(),
      initialRoute: '/',
    );
  }
}
