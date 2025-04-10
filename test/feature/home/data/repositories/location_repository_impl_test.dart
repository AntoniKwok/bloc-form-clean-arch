import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sdg/src/feature/home/data/models/country_response.dart';
import 'package:sdg/src/feature/home/data/models/state_response.dart';
import 'package:sdg/src/feature/home/data/repositories/location_repository_impl.dart';
import 'package:sdg/src/feature/home/data/sources/location_data_source.dart';
import 'package:sdg/src/feature/home/domain/models/country_data.dart';
import 'package:sdg/src/feature/home/domain/models/state_data.dart';

class MockLocationDataSource extends Mock implements LocationDataSource {}

void main() {
  late LocationRepositoryImpl repository;
  late MockLocationDataSource mockDataSource;

  setUp(() {
    mockDataSource = MockLocationDataSource();
    repository = LocationRepositoryImpl(locationDataSource: mockDataSource);
  });

  group('LocationRepositoryImpl', () {
    test('returns List<CountryData> from getCountries()', () async {
      when(() => mockDataSource.getCountries()).thenAnswer(
        (_) async => [
          const CountryResponse(id: 1, value: 'Indonesia'),
          const CountryResponse(id: 2, value: 'Japan'),
        ],
      );

      final result = await repository.getCountries();

      expect(result, isA<List<CountryData>>());
      expect(result.length, 2);
      expect(result[0].id, 1);
      expect(result[0].value, 'Indonesia');
      expect(result[1].id, 2);
      expect(result[1].value, 'Japan');
    });

    test('returns List<StateData> from getStates()', () async {
      when(() => mockDataSource.getStates(1)).thenAnswer(
        (_) async => [
          const StateResponse(id: 10, value: 'Jakarta'),
          const StateResponse(id: 11, value: 'Bali'),
        ],
      );

      final result = await repository.getStates(1);

      expect(result, isA<List<StateData>>());
      expect(result.length, 2);
      expect(result[0].id, 10);
      expect(result[0].value, 'Jakarta');
      expect(result[1].id, 11);
      expect(result[1].value, 'Bali');
    });
  });
}
