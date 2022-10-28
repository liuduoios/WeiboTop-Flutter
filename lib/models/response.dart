import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:weibo_top/models/top.dart';
import 'package:http/http.dart' as http;

class Response {
  final int code;
  final String msg;
  final List<Top> data;
  final int time;
  final int logId;

  const Response({
    required this.code,
    required this.msg,
    required this.data,
    required this.time,
    required this.logId,
  });

  factory Response.fromJson(Map<String, dynamic> json) {
    return Response(
      code: json["code"],
      msg: json["msg"],
      data: json['data'].map<Top>((json) => Top.fromJson(json)).toList(),
      time: json['time'],
      logId: json['log_id'],
    );
  }
}

Future<List<Top>> fetchTops() async {
  final url = "https://v2.alapi.cn/api/new/wbtop?num=20&token=LwExDtUWhF3rH5ib";
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    final res = Response.fromJson(jsonDecode(response.body));
    return res.data;
  } else {
    throw Exception("Failed to load tops");
  }
}

Future<List<Top>> fetchTopsFromLocal() async {
  final json = await rootBundle.loadString('assets/response.json');
  final response = Response.fromJson(jsonDecode(json));
  return response.data;
}
