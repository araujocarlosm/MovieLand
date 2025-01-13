import 'package:dio/dio.dart';

class DioInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print("DioInterceptor onRequest: ${options.uri.toString()}");
    print("DioInterceptor onRequest: ${options.headers}");
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    print("DioInterceptor onError: ${err.message}");
    super.onError(err, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print("DioInterceptor onResponse: ${response.statusCode}");
    print("DioInterceptor onResponse: ${response.data}");
    super.onResponse(response, handler);
  }
}
