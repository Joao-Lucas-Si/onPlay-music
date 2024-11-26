import 'dart:typed_data';
import 'package:flutter/material.dart';
import "package:http/http.dart" as http;

class HttpAdapter {
  Future<Uint8List> getBytes(String url) async {
    debugPrint(url);
    final response = await http.get(Uri.parse(url));

    return response.bodyBytes;
  }
}
// 