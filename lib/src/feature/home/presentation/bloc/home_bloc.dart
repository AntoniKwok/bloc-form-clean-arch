import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sdg/src/feature/home/domain/models/country_data.dart';
import 'package:sdg/src/feature/home/domain/models/state_data.dart';
import 'package:sdg/src/feature/home/domain/repositories/location_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final LocationRepository locationRepository;

  HomeBloc({required this.locationRepository}) : super(HomeInitial()) {
    on<LoadCountriesEvent>(_onLoadCountries);
    on<SelectCountryEvent>(_onSelectCountry);
    on<SelectStateEvent>(_onSelectState);
  }

  Future<void> _onLoadCountries(
    LoadCountriesEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(CountriesLoadingState());
    try {
      await locationRepository.getCountries().then((countries) {
        emit(CountriesLoadedState(countries: countries));
      });
    } catch (e) {
      emit(HomeErrorState(error: e.toString()));
    }
  }

  Future<void> _onSelectCountry(
    SelectCountryEvent event,
    Emitter<HomeState> emit,
  ) async {
    final currentState = state;
    List<CountryData> countries = [];

    if (currentState is CountriesLoadedState) {
      countries = currentState.countries;
    } else if (currentState is StatesLoadedState) {
      countries = currentState.countries;
    }

    emit(StatesLoadingState(
      countries: countries,
      selectedCountryId: event.countryId,
    ));

    try {
      await locationRepository.getStates(event.countryId).then((states) {
        emit(StatesLoadedState(
          countries: countries,
          selectedCountryId: event.countryId,
          states: states,
        ));
      });
    } catch (e) {
      emit(HomeErrorState(error: e.toString()));
    }
  }

  Future<void> _onSelectState(
    SelectStateEvent event,
    Emitter<HomeState> emit,
  ) async {
    final currentState = state;
    if (currentState is StatesLoadedState) {
      emit(StatesLoadedState(
        countries: currentState.countries,
        selectedCountryId: currentState.selectedCountryId,
        states: currentState.states,
        selectedStateId: event.stateId,
      ));
    }
  }
}
