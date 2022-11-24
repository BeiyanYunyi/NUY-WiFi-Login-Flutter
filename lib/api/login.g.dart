// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginReq _$LoginReqFromJson(Map<String, dynamic> json) => LoginReq(
      username: json['username'] as String,
      password: json['password'] as String,
      channel: json['channel'] as String,
      ifautologin: json['ifautologin'] as String,
      pagesign: json['pagesign'] as String,
      usripadd: json['usripadd'] as String,
    );

Map<String, dynamic> _$LoginReqToJson(LoginReq instance) => <String, dynamic>{
      'username': instance.username,
      'password': instance.password,
      'channel': instance.channel,
      'ifautologin': instance.ifautologin,
      'pagesign': instance.pagesign,
      'usripadd': instance.usripadd,
    };

LoginRes _$LoginResFromJson(Map<String, dynamic> json) => LoginRes(
      code: json['code'] as int,
      message: json['message'] as String,
      data: json['data'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$LoginResToJson(LoginRes instance) => <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
