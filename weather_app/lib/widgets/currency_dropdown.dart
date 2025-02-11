import 'package:flutter/material.dart';

class CurrencyDropdown extends StatelessWidget {
  final String selectedCurrency;
  final Function(String) onCurrencyChanged;
  final List<String> currencies;

  CurrencyDropdown({
    required this.selectedCurrency,
    required this.onCurrencyChanged,
    required this.currencies,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: selectedCurrency,
      onChanged: (String? newValue) {
        onCurrencyChanged(newValue!);
      },
      items: currencies.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
