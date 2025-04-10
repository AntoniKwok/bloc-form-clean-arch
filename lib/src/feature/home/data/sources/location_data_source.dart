import 'package:sdg/src/core/network/network_service.dart';
import 'package:sdg/src/feature/home/data/models/country_response.dart';
import 'package:sdg/src/feature/home/data/models/state_response.dart';

class LocationDataSource {
  final NetworkService service;

  LocationDataSource({required this.service});

  Future<List<CountryResponse>> getCountries() async {
    try {
      final response = await service.dio.get('/countries');
      final List<dynamic> data = response.data;
      return data.map((json) => CountryResponse.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to load countries: $e');
    }
  }

  Future<List<StateResponse>> getStates(int countryId) async {
    try {
      final response = await service.dio.get('/countries/$countryId/states');
      final List<dynamic> data = response.data;
      return data.map((json) => StateResponse.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to load states: $e');
    }
  }
}
