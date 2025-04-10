import 'package:equatable/equatable.dart';

class StateData extends Equatable {
  final int id;
  final String value;

  const StateData({required this.id, required this.value});

  @override
  List<Object?> get props => [id, value];
}
