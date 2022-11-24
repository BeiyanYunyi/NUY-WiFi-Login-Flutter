import 'dart:convert';

import 'package:fast_gbk/fast_gbk.dart';
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';
import 'package:wifilogin/data/login_form_data.dart';

part 'login.g.dart';

@JsonSerializable()
class LoginReq {
  final String username;
  final String password;
  final String channel;
  final String ifautologin;
  final String pagesign;
  final String usripadd;
  const LoginReq(
      {required this.username,
      required this.password,
      required this.channel,
      required this.ifautologin,
      required this.pagesign,
      required this.usripadd});
  factory LoginReq.fromJson(Map<String, dynamic> json) =>
      _$LoginReqFromJson(json);
  static Map<String, dynamic> toJson(LoginReq res) => _$LoginReqToJson(res);
}

@JsonSerializable()
class LoginRes {
  final int code;
  final String message;
  final Map<String, dynamic> data;
  const LoginRes(
      {required this.code, required this.message, required this.data});
  factory LoginRes.fromJson(Map<String, dynamic> json) =>
      _$LoginResFromJson(json);
  Map<String, dynamic> toJson(LoginRes res) => _$LoginResToJson(res);
}

Future<LoginRes> login(
    {required LoginFormData form, required String ip}) async {
  final url = Uri.parse('http://10.255.255.46/api/v1/login');
  String isp = '';
  switch (form.isp) {
    case ISP.nuist:
      isp = '1';
      break;
    case ISP.cmcc:
      isp = '2';
      break;
    case ISP.chinaNet:
      isp = '3';
      break;
    default:
      isp = '4';
  }
  final response = await http.post(url,
      body: jsonEncode(LoginReq.toJson(LoginReq(
          username: form.username,
          password: form.password,
          channel: isp,
          ifautologin: '1',
          pagesign: "secondauth",
          usripadd: ip))));
  if (response.statusCode != 200) {
    throw Exception("Failed to login");
  }
  final res =
      LoginRes.fromJson(jsonDecode(gbk.decode(latin1.encode(response.body))));
  if (res.code != 200) {
    if (res.data["text"] != null) {
      throw Exception(res.data["text"]);
    } else {
      throw Exception(res.message);
    }
  }
  return res;
}
