
import 'package:onPlay/services/http/serializable.dart';

abstract class HttpRequestAdapter<T extends Serializable> {
  String? baseUrl;
  T Function(Map<String, dynamic>) constructor;
  HttpRequestAdapter({required this.baseUrl, required this.constructor});

  Future<T> getRequestUnique(String uri, { Map<String, dynamic>? params });

  Future<List<T>> getRequestMany(String uri, { Map<String, dynamic>? params });

  Future<T> postRequestUnique(String uri, T body);

  Future<void> postRequestWithoutResponse(String uri, T body);

  // Future<Uint8List> readImage(String uri);
}
