import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sdg/src/core/network/network_service.dart';
import 'package:sdg/src/feature/home/data/models/country_response.dart';
import 'package:sdg/src/feature/home/data/models/state_response.dart';
import 'package:sdg/src/feature/home/data/sources/location_data_source.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late MockDio mockDio;
  late NetworkService networkService;
  late LocationDataSource dataSource;

  setUp(() {
    dotenv.testLoad(fileInput: '''
      BASE_URL=https://mockapi.test
      API_KEY=test-api-key
    ''');
    mockDio = MockDio();
    when(() => mockDio.options).thenReturn(BaseOptions());
    networkService = NetworkService(mockDio);
    dataSource = LocationDataSource(service: networkService);
  });

  group('LocationDataSource', () {
    test('returns list of CountryResponse from getCountries()', () async {
      final mockResponseData = [
        {'id': 1, 'value': 'Indonesia'},
        {'id': 2, 'value': 'Japan'},
      ];

      when(() => mockDio.get('/countries')).thenAnswer(
        (_) async => Response(
          data: mockResponseData,
          requestOptions: RequestOptions(path: '/countries'),
          statusCode: 200,
        ),
      );

      final result = await dataSource.getCountries();

      expect(result, isA<List<CountryResponse>>());
      expect(result.length, 2);
      expect(result[0].id, 1);
      expect(result[0].value, 'Indonesia');
    });

    test('returns list of StateResponse from getStates()', () async {
      final mockResponseData = [
        {'id': 10, 'value': 'Jakarta'},
        {'id': 11, 'value': 'Bali'},
      ];

      when(() => mockDio.get('/countries/1/states')).thenAnswer(
        (_) async => Response(
          data: mockResponseData,
          requestOptions: RequestOptions(path: '/countries/1/states'),
          statusCode: 200,
        ),
      );

      final result = await dataSource.getStates(1);

      expect(result, isA<List<StateResponse>>());
      expect(result[1].id, 11);
      expect(result[1].value, 'Bali');
    });

    test('throws exception when getCountries() fails', () async {
      when(() => mockDio.get('/countries'))
          .thenThrow(Exception('Network Error'));

      expect(() => dataSource.getCountries(), throwsException);
    });

    test('throws exception when getStates() fails', () async {
      when(() => mockDio.get('/countries/1/states'))
          .thenThrow(Exception('Network Error'));

      expect(() => dataSource.getStates(1), throwsException);
    });
  });
}
