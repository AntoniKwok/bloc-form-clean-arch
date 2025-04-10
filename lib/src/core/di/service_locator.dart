import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:sdg/src/core/network/network_service.dart';
import 'package:sdg/src/feature/home/data/repositories/location_repository_impl.dart';
import 'package:sdg/src/feature/home/data/sources/location_data_source.dart';
import 'package:sdg/src/feature/home/domain/repositories/location_repository.dart';
import 'package:sdg/src/feature/home/presentation/bloc/home_bloc.dart';

final locator = GetIt.instance;

Future<void> init() async {
  locator.registerLazySingleton<Dio>(() => Dio());

  locator.registerLazySingleton<NetworkService>(
      () => NetworkService(locator<Dio>()));

  locator.registerLazySingleton<LocationDataSource>(
      () => LocationDataSource(service: locator<NetworkService>()));

  locator.registerLazySingleton<LocationRepository>(() =>
      LocationRepositoryImpl(
          locationDataSource: locator<LocationDataSource>()));

  locator.registerFactory<HomeBloc>(
      () => HomeBloc(locationRepository: locator<LocationRepository>()));
}
