import 'package:equatable/equatable.dart';

class CountryData extends Equatable {
  final int id;
  final String value;

  const CountryData({required this.id, required this.value});

  @override
  List<Object?> get props => [id, value];
}
