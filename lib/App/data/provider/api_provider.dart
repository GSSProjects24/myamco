// lib/App/data/provider/api_provider.dart
import 'package:dio/dio.dart';
import 'package:myamco/App/data/provider/canstant.dart';


class ApiProvider {
  final Dio _dio;

  ApiProvider._internal()
      : _dio = Dio(
    BaseOptions(
      baseUrl: Constants.baseUrl,
      connectTimeout: const Duration(milliseconds: 15000),
      receiveTimeout: const Duration(milliseconds: 10000),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      validateStatus: (status) => status != null && status < 500,
    ),
  ) {
    _dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
    ));
  }

  static final ApiProvider _instance = ApiProvider._internal();

  static ApiProvider get instance => _instance;

  Dio get client => _dio;
}
