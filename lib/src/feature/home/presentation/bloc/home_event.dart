part of 'home_bloc.dart';

sealed class HomeEvent {}

class LoadCountriesEvent extends HomeEvent {}

class SelectCountryEvent extends HomeEvent {
  final int countryId;

  SelectCountryEvent({required this.countryId});
}

class SelectStateEvent extends HomeEvent {
  final int stateId;

  SelectStateEvent({required this.stateId});
}

class SubmitSelectionEvent extends HomeEvent {
  final CountryData country;
  final StateData state;

  SubmitSelectionEvent({required this.country, required this.state});
}
