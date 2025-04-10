import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class NetworkService {
  final Dio dio;

  NetworkService(this.dio) {
    dio.options.baseUrl = dotenv.env['BASE_URL'] ?? '';
    dio.options.headers = {'x-api-key': dotenv.env['API_KEY'] ?? ''};
    dio.options.connectTimeout = const Duration(seconds: 5);
    dio.options.receiveTimeout = const Duration(seconds: 3);
  }
}
