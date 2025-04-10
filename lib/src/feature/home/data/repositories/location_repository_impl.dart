import 'package:sdg/src/feature/home/data/sources/location_data_source.dart';
import 'package:sdg/src/feature/home/domain/models/country_data.dart';
import 'package:sdg/src/feature/home/domain/models/state_data.dart';
import 'package:sdg/src/feature/home/domain/repositories/location_repository.dart';

class LocationRepositoryImpl extends LocationRepository {
  final LocationDataSource locationDataSource;

  LocationRepositoryImpl({required this.locationDataSource});

  @override
  Future<List<CountryData>> getCountries() async {
    return await locationDataSource.getCountries().then((countries) {
      return countries.map((country) {
        return CountryData(
          id: country.id,
          value: country.value,
        );
      }).toList();
    });
  }

  @override
  Future<List<StateData>> getStates(int countryId) async {
    return await locationDataSource.getStates(countryId).then((states) {
      return states.map((state) {
        return StateData(
          id: state.id,
          value: state.value,
        );
      }).toList();
    });
  }
}
