import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';

part 'get_ip.g.dart';

@JsonSerializable()
class GetIPRes {
  final int code;
  final String data;
  const GetIPRes({required this.code, required this.data});
  factory GetIPRes.fromJson(Map<String, dynamic> json) =>
      _$GetIPResFromJson(json);
  Map<String, dynamic> toJson(GetIPRes res) => _$GetIPResToJson(res);
}

Future<GetIPRes> getIP() async {
  final url = Uri.parse('http://10.255.255.46/api/v1/ip');
  final response = await http.get(url);
  if (response.statusCode == 200) {
    return GetIPRes.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load IP');
  }
}
