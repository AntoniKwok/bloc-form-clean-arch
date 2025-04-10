import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sdg/src/core/network/network_service.dart';

void main() {
  setUp(() {
    dotenv.testLoad(fileInput: '''
      BASE_URL=https://mockapi.test
      API_KEY=test-api-key
    ''');
  });

  group('NetworkService', () {
    test('should configure Dio with baseUrl and headers', () {
      final dio = Dio();
      final networkService = NetworkService(dio);

      expect(networkService.dio.options.baseUrl, isNotEmpty);
      expect(networkService.dio.options.headers['x-api-key'], isNotNull);
      expect(networkService.dio.options.connectTimeout,
          const Duration(seconds: 5));
      expect(networkService.dio.options.receiveTimeout,
          const Duration(seconds: 3));
    });
  });
}
