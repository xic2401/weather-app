class Currency {
  final String name;
  final double exchangeRate;

  Currency({required this.name, required this.exchangeRate});
  factory Currency.fromJson(Map<String, dynamic> json) {
    return Currency(name: json['code'], exchangeRate: json['value'] / 1);
  }
}
