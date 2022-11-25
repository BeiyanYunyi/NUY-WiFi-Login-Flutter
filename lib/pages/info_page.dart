import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: SingleChildScrollView(
          child: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "元带 WiFi",
              style: Theme.of(context).textTheme.headline4,
            ),
            const Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Text(
                  "你说得对，但是元带 WiFi 是由元带网络使用 Flutter 开发的一款跨平台原生的南元带 WiFi 登录应用。"),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                "注意事项",
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Text(
                  "在使用本 App 作为打开方式打开“连接到 i-NUSHIT”时，请勿选择“总是”，否则你就没法连其它需要用这种方式登录的 WiFi 了，除非卸载重装。"),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                "开发者",
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Text("产品：李家坟头来种树"),
            ),
            const Text("开发：鱼肥果熟入我肚"),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                "开源协议",
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Text("本应用使用 AGPL-3.0 协议开源。"),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 8.0,
              ),
              child: TextButton(
                onPressed: () => {
                  launchUrl(
                      Uri.parse(
                          "https://github.com/lixiang810/NUY-WiFi-Login-Flutter"),
                      mode: LaunchMode.externalApplication)
                },
                child: const Text("查看源代码"),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
