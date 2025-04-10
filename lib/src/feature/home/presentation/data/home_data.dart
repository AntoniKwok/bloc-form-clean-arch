import 'package:sdg/src/feature/home/domain/models/country_data.dart';
import 'package:sdg/src/feature/home/domain/models/state_data.dart';

class HomeData {
  final List<CountryData> countries;
  final List<StateData> states;
  final CountryData? selectedCountry;
  final StateData? selectedState;
  final bool isLoadingStates;

  HomeData({
    required this.countries,
    required this.states,
    this.selectedCountry,
    this.selectedState,
    this.isLoadingStates = false,
  });
}
