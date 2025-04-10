import 'package:sdg/src/feature/home/domain/models/country_data.dart';
import 'package:sdg/src/feature/home/domain/models/state_data.dart';

abstract class LocationRepository {
  Future<List<CountryData>> getCountries();

  Future<List<StateData>> getStates(int countryId);
}
