import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wifilogin/data/consts.dart';
import 'package:wifilogin/data/login_form_data.dart';

class Form extends StatelessWidget {
  const Form({super.key});
  @override
  Widget build(BuildContext context) {
    final LoginFormData c = Get.find();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(top: appMargin),
          child: TextField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: '用户名',
            ),
            controller: c.usernameController,
            onChanged: (value) => c.username.value = value,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: appMargin),
          child: TextField(
            obscureText: true,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: '密码',
            ),
            controller: c.passwordController,
            onChanged: (value) => c.password.value = value,
          ),
        ),
        Container(
            margin: const EdgeInsets.only(top: appMargin),
            child: Obx(() => DropdownButtonFormField(
                isExpanded: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "运营商",
                ),
                borderRadius: BorderRadius.circular(10),
                items: const [
                  DropdownMenuItem(value: ISP.cmcc, child: Text('中国移动')),
                  DropdownMenuItem(value: ISP.chinaNet, child: Text('中国电信')),
                  DropdownMenuItem(value: ISP.chinaUnicom, child: Text('中国联通')),
                  DropdownMenuItem(value: ISP.nuy, child: Text('元带土著')),
                ],
                value: c.isp.value,
                onChanged: (value) => c.isp.value = value ?? ISP.cmcc))),
        Container(
            margin: const EdgeInsets.only(top: appMargin),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("自动登录"),
                Obx(() => Switch(
                      value: c.autoLogin.value,
                      onChanged: (value) async {
                        await c.setAutoLogin(value);
                      },
                    )),
              ],
            ))
      ],
    );
  }
}
