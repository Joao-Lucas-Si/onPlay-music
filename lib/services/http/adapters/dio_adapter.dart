import 'package:dio/dio.dart';
import 'package:onPlay/services/http/http_request_adapter.dart';
import 'package:onPlay/services/http/serializable.dart';

class DioAdapter<Model extends Serializable> extends HttpRequestAdapter<Model> {
  Dio dio = Dio();

  String getEndpoint(String uri) {
    return baseUrl != null ? (baseUrl! + (baseUrl!.endsWith("/") ? "" : "/") + uri) : uri;
  }

  DioAdapter({super.baseUrl, required super.constructor});

  @override
  Future<Model> getRequestUnique(String uri,
      {Map<String, dynamic>? params}) async {
    final response = await dio.get(getEndpoint(uri),
        queryParameters: params,
        options: Options(responseType: ResponseType.json));
  
    return constructor(response.data as Map<String, dynamic>);
  }

  @override
  Future<List<Model>> getRequestMany(String uri,
      {Map<String, dynamic>? params}) async {
    
    final response = await dio.get(
      getEndpoint(uri),
      queryParameters: params,
    );
   
    if (response.data == null) throw Exception("");
    return response.data!
        .map<Model>((content) => constructor(content))
        .toList();
  }

  @override
  Future<Model> postRequestUnique(String uri, Model body) async {
    final response = await dio.post(getEndpoint(uri), data: body.toJson());
    return constructor(response.data);
  }

  @override
  Future<void> postRequestWithoutResponse(String uri, Model body) async {
    
    await dio.post(getEndpoint(uri), data: body.toJson());
  }

  // @override
  // Future<Uint8List> readImage(String url) async {
  //   return (await dio.get(url, options: Options(responseType: ResponseType.bytes))).
  // }
}
