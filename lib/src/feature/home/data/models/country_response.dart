class CountryResponse {
  final int id;
  final String value;

  const CountryResponse({required this.id, required this.value});

  factory CountryResponse.fromJson(Map<String, dynamic> json) {
    return CountryResponse(
      id: json['id'],
      value: json['value'],
    );
  }
}
