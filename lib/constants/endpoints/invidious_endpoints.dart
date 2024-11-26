class InvidiousEndpoints {
  static const _apiEndpoint = "api/v1/";
  static String channel(String id) => id;
  static const search = "${_apiEndpoint}search";
  static String video(String id) => "${_apiEndpoint}videos/$id";
}
