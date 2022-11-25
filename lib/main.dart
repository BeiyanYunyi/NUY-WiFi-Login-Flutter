import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wifilogin/components/my_home_page.dart';
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
    return GetMaterialApp(
      title: '信带 WiFi',
      theme: ThemeData(
        fontFamily: 'customFont',
        primarySwatch: Colors.teal,
        useMaterial3: true,
        // colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)),
      ),
      darkTheme: ThemeData.dark(useMaterial3: true),
      initialRoute: '/',
      getPages: [
        GetPage(
            name: '/',
            page: () => const MyHomePage(title: '信带 WiFi'),
            transition: Transition.leftToRight,
            transitionDuration: const Duration(milliseconds: 200)),
        GetPage(
            name: '/my',
            page: () => const MyHomePage(title: '我对信带的看法'),
            transition: Transition.rightToLeft,
            transitionDuration: const Duration(milliseconds: 200)),
      ],
    );
  }
}
