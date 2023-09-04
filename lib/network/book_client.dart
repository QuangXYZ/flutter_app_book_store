import 'package:dio/dio.dart';

class BookClient {
  static final BaseOptions _options = BaseOptions(
      baseUrl: "http://192.168.1.8:8000",
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3));

  static Dio _dio = Dio(_options);
  BookClient._internal() {
    _dio.interceptors.add(LogInterceptor(requestBody: true));
  }
  static final BookClient instance = BookClient._internal();
  Dio get get => _dio;
}
