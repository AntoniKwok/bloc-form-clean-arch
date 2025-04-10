import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sdg/src/core/di/service_locator.dart';
import 'package:sdg/src/feature/home/domain/models/country_data.dart';
import 'package:sdg/src/feature/home/domain/models/state_data.dart';
import 'package:sdg/src/feature/home/presentation/bloc/home_bloc.dart';
import 'package:sdg/src/feature/home/presentation/data/home_data.dart';
import 'package:sdg/src/feature/home/presentation/widget/custom_dropdown_widget.dart';
import 'package:sdg/src/feature/home/presentation/widget/error_view_widget.dart';
import 'package:sdg/src/feature/summary/data/summary_data.dart';
import 'package:sdg/src/feature/summary/page/summary_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => locator<HomeBloc>()..add(LoadCountriesEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('SDG'),
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        ),
        body: const Padding(
          padding: EdgeInsets.all(16.0),
          child: _HomeContent(),
        ),
      ),
    );
  }
}

class _HomeContent extends StatelessWidget {
  const _HomeContent();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is HomeInitial || state is CountriesLoadingState) {
          return const CircularProgressIndicator();
        }

        if (state is HomeErrorState) {
          return ErrorViewWidget(error: state.error);
        }

        // Extract state data
        final HomeData stateData = _extractStateData(state);

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Select a country and state:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              CustomDropdown<CountryData>(
                items: stateData.countries,
                onChanged: (country) {
                  context.read<HomeBloc>().add(
                        SelectCountryEvent(countryId: country.id),
                      );
                },
                getLabel: (state) => state.value,
                label: 'Country',
                selectedItem: stateData.selectedCountry,
              ),
              const SizedBox(height: 16),
              if (stateData.isLoadingStates)
                const CircularProgressIndicator()
              else if (stateData.selectedCountry != null)
                CustomDropdown<StateData>(
                  items: stateData.states,
                  onChanged: (state) {
                    context
                        .read<HomeBloc>()
                        .add(SelectStateEvent(stateId: state.id));
                  },
                  getLabel: (state) => state.value,
                  label: 'State',
                  selectedItem: stateData.selectedState,
                ),
              ElevatedButton(
                onPressed: () {
                  final selectedCountry = stateData.selectedCountry;
                  final selectedState = stateData.selectedState;

                  if (selectedCountry != null && selectedState != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SummaryPage(
                          summaryData: SummaryData(
                            countryName: selectedCountry.value,
                            stateName: selectedState.value,
                          ),
                        ),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content:
                              Text('Please select both country and state')),
                    );
                  }
                },
                child: const Text("Submit"),
              )
            ],
          ),
        );
      },
    );
  }

  HomeData _extractStateData(HomeState state) {
    List<CountryData> countries = [];
    List<StateData> states = [];
    CountryData? selectedCountry;
    StateData? selectedState;
    bool isLoadingStates = false;

    if (state is CountriesLoadedState) {
      countries = state.countries;
    } else if (state is StatesLoadingState) {
      countries = state.countries;
      selectedCountry = _findCountryById(countries, state.selectedCountryId);
      isLoadingStates = true;
    } else if (state is StatesLoadedState) {
      countries = state.countries;
      selectedCountry = _findCountryById(countries, state.selectedCountryId);
      states = state.states;
      selectedState = state.selectedStateId != null
          ? _findStateById(states, state.selectedStateId)
          : null;
    }

    return HomeData(
      countries: countries,
      states: states,
      selectedCountry: selectedCountry,
      selectedState: selectedState,
      isLoadingStates: isLoadingStates,
    );
  }

  CountryData? _findCountryById(List<CountryData> countries, int id) {
    try {
      return countries.firstWhere((c) => c.id == id);
    } catch (_) {
      return null;
    }
  }

  StateData? _findStateById(List<StateData> states, int? id) {
    try {
      return states.firstWhere((c) => c.id == id);
    } catch (_) {
      return null;
    }
  }
}
