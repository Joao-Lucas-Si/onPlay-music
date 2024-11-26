import 'package:onPlay/services/http/adapters/dio_adapter.dart';
import 'package:onPlay/services/http/http_request_adapter.dart';
import 'package:onPlay/services/http/serializable.dart';

class HttpRequest<Model extends Serializable> {
  late HttpRequestAdapter<Model> adapter;

  HttpRequest(String baseUrl, Model Function(Map<String, dynamic>) constructor) {
    adapter = DioAdapter<Model>(baseUrl: baseUrl, constructor: constructor);
  }

  Future<Model> getRequestUnique(String uri) async {
    return await adapter.getRequestUnique(uri);
  }

  Future<List<Model>> getRequestMany(String uri, { Map<String, dynamic>? params }) => adapter.getRequestMany(uri, params: params);

  Future<Model> postRequestUnique(String uri, Model body) async {
    return await adapter.postRequestUnique(uri, body);
  }

  Future<void> postRequestWithoutResponse(String uri, Model body) async {
    await adapter.postRequestWithoutResponse(uri, body);
  }
}
