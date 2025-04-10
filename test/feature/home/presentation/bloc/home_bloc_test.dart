import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sdg/src/feature/home/domain/models/country_data.dart';
import 'package:sdg/src/feature/home/domain/models/state_data.dart';
import 'package:sdg/src/feature/home/domain/repositories/location_repository.dart';
import 'package:sdg/src/feature/home/presentation/bloc/home_bloc.dart';

class MockLocationRepository extends Mock implements LocationRepository {}

void main() {
  late HomeBloc homeBloc;
  late LocationRepository locationRepository;

  final countries = [
    const CountryData(id: 1, value: 'Indonesia'),
    const CountryData(id: 2, value: 'Japan'),
  ];

  final states = [
    const StateData(id: 10, value: 'Jakarta'),
    const StateData(id: 11, value: 'Hokkaido'),
  ];

  setUp(() {
    locationRepository = MockLocationRepository();
    homeBloc = HomeBloc(locationRepository: locationRepository);
  });

  tearDown(() {
    homeBloc.close();
  });

  group('HomeBlocTest', () {
    blocTest<HomeBloc, HomeState>(
      'Should emits [CountriesLoadingState, CountriesLoadedState] when LoadCountriesEvent is added',
      build: () {
        when(() => locationRepository.getCountries())
            .thenAnswer((_) async => countries);
        return homeBloc;
      },
      act: (bloc) => bloc.add(LoadCountriesEvent()),
      expect: () => [
        CountriesLoadingState(),
        CountriesLoadedState(countries: countries),
      ],
    );

    blocTest<HomeBloc, HomeState>(
      'Should emits [StatesLoadingState, StatesLoadedState] when SelectCountryEvent is added after LoadCountriesEvent',
      build: () {
        when(() => locationRepository.getCountries())
            .thenAnswer((_) async => countries);
        when(() => locationRepository.getStates(1))
            .thenAnswer((_) async => states);
        return homeBloc;
      },
      act: (bloc) async {
        bloc.add(LoadCountriesEvent());
        await Future.delayed(Duration.zero); // allow previous event to complete
        bloc.add(SelectCountryEvent(countryId: 1));
      },
      skip: 2, // skip loading + loaded from LoadCountries to focus on States
      expect: () => [
        StatesLoadingState(countries: countries, selectedCountryId: 1),
        StatesLoadedState(
          countries: countries,
          selectedCountryId: 1,
          states: states,
        ),
      ],
    );

    blocTest<HomeBloc, HomeState>(
      'Should emits updated StatesLoadedState with selectedStateId when SelectStateEvent is added',
      build: () => homeBloc,
      seed: () => StatesLoadedState(
        countries: countries,
        selectedCountryId: 1,
        states: states,
      ),
      act: (bloc) => bloc.add(SelectStateEvent(stateId: 10)),
      expect: () => [
        StatesLoadedState(
          countries: countries,
          selectedCountryId: 1,
          states: states,
          selectedStateId: 10,
        ),
      ],
    );
  });
}
