import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:onPlay/services/http/http_request_adapter.dart';
import 'package:onPlay/services/http/serializable.dart';

class DioAdapter<Model extends Serializable> extends HttpRequestAdapter<Model> {
  Dio dio = Dio();

  String getEndpoint(String uri) {
    return baseUrl + (baseUrl.endsWith("/") ? "" : "/") + uri;
  }

  DioAdapter({required super.baseUrl, required super.constructor});

  @override
  Future<Model> getRequestUnique(String uri) async {
    final response = await dio.get(getEndpoint(uri));
    response.data;
    return constructor(response.data);
  }

  @override
  Future<Model> postRequestUnique(String uri, Model body) async {
    final response = await dio.post(getEndpoint(uri), data: body.toJson());
    return constructor(response.data);
  }

  @override
  Future<void> postRequestWithoutResponse(String uri, Model body) async {
    debugPrint(getEndpoint(uri));
    await dio.post(getEndpoint(uri), data: body.toJson());
  }
}
