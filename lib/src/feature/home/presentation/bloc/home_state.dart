part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {}

class CountriesLoadingState extends HomeState {}

class CountriesLoadedState extends HomeState {
  final List<CountryData> countries;

  const CountriesLoadedState({required this.countries});

  @override
  List<Object?> get props => [countries];
}

class StatesLoadingState extends HomeState {
  final List<CountryData> countries;
  final int selectedCountryId;

  const StatesLoadingState({
    required this.countries,
    required this.selectedCountryId,
  });

  @override
  List<Object?> get props => [countries, selectedCountryId];
}

class StatesLoadedState extends HomeState {
  final List<CountryData> countries;
  final int selectedCountryId;
  final List<StateData> states;
  final int? selectedStateId;

  const StatesLoadedState({
    required this.countries,
    required this.selectedCountryId,
    required this.states,
    this.selectedStateId,
  });

  @override
  List<Object?> get props =>
      [countries, selectedCountryId, states, selectedStateId];
}

class HomeErrorState extends HomeState {
  final String error;

  const HomeErrorState({required this.error});

  @override
  List<Object?> get props => [error];
}
