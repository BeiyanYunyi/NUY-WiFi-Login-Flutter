import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wifilogin/data/consts.dart';
import 'package:wifilogin/data/login_form_data.dart';

class Form extends StatefulWidget {
  const Form({super.key});

  @override
  State<Form> createState() => _FormState();
}

class _FormState extends State<Form> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        DropdownButton(
            items: const [
              DropdownMenuItem(value: ISP.cmcc, child: Text('中国移动')),
              DropdownMenuItem(value: ISP.chinaNet, child: Text('中国电信')),
              DropdownMenuItem(value: ISP.chinaUnicom, child: Text('中国联通')),
              DropdownMenuItem(value: ISP.nuist, child: Text('信带土著')),
            ],
            value: Provider.of<LoginFormData>(context).isp,
            onChanged: (value) =>
                Provider.of<LoginFormData>(context, listen: false)
                    .setISP(value ?? ISP.cmcc)),
        Container(
          margin: const EdgeInsets.only(top: appMargin),
          child: TextField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: '用户名',
            ),
            onChanged: (value) =>
                Provider.of<LoginFormData>(context, listen: false)
                    .setUsername(value),
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
            onChanged: (value) =>
                Provider.of<LoginFormData>(context, listen: false)
                    .setPassword(value),
          ),
        )
      ],
    );
  }
}
