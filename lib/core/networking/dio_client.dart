import 'package:dio/dio.dart';
import 'package:movie_land/config/constants.dart';
import 'package:movie_land/core/networking/dio_interceptor.dart';
import 'package:movie_land/core/networking/http_client.dart';

class DioClient implements HttpClient {
  final Dio _dio;

  DioClient({String? apiKey})
      : _dio = Dio(
          BaseOptions(
            baseUrl: moviesBaseUrl,
            headers: {
              'Content-Type': 'application/json',
              if (apiKey != null) 'Authorization': 'Bearer $apiKey'
            },
          ),
        )..interceptors.add(DioInterceptor());

  void setBearerToken(String token) {
    _dio.options.headers['Authorization'] = 'Bearer $token';
  }

  @override
  Future<dynamic> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.get(path, queryParameters: queryParameters);
      if (response.statusCode == 200) {
        return response.data as Map<String, dynamic>;
      } else {
        throw 'Error: Status Code ${response.statusCode}';
      }
    } on DioException catch (e) {
      final dioResponse = e.response;
      if (dioResponse != null) {
        throw Exception('Error ${dioResponse.statusCode}: ${dioResponse.statusMessage}');
      } else {
        throw Exception('Error: ${e.message}');
      }
    }
  }
}
