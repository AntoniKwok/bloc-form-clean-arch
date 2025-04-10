class StateResponse {
  final int id;
  final String value;

  const StateResponse({required this.id, required this.value});

  factory StateResponse.fromJson(Map<String, dynamic> json) {
    return StateResponse(
      id: json['id'],
      value: json['value'],
    );
  }
}
