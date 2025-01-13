abstract class HttpClient {
  Future<dynamic> get(String path, {Map<String, dynamic>? queryParameters});
}
