import 'package:onPlay/services/http/serializable.dart';

abstract class HttpRequestAdapter<T extends Serializable> {
  String baseUrl;
  T Function(Map<String, dynamic>) constructor;
  HttpRequestAdapter({required this.baseUrl, required this.constructor});

  Future<T> getRequestUnique(String uri);

  // Future<List<T>> getRequestMany(String uri);

  Future<T> postRequestUnique(String uri, T body);

  Future<void> postRequestWithoutResponse(String uri, T body);
}
