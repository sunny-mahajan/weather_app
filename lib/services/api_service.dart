import 'package:dio/dio.dart';
import '../core/constants.dart' as constants;

class ApiService {
  final Dio _dio;

  ApiService() : _dio = Dio() {
    _dio.options.baseUrl = 'https://api.openweathermap.org/data/2.5/';
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        options.queryParameters['appid'] = constants.APP_ID;
        return handler.next(options);
      },
    ));
  }

  Future<dynamic> get(String endpoint,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      final response =
          await _dio.get(endpoint, queryParameters: queryParameters);
      return response.data;
    } catch (e) {
      throw Exception('Failed to fetch data: $e');
    }
  }
}
