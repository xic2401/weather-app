import 'package:flutter/material.dart';
import 'package:weather_app/services/services_currency.dart';

class ConverterScreen extends StatefulWidget {
  const ConverterScreen({super.key});

  @override
  ConverterScreenState createState() => ConverterScreenState();
}

class ConverterScreenState extends State<ConverterScreen> {
  final TextEditingController amountController = TextEditingController();
  final List<String> currencies = ['USD', 'EUR', 'KZT'];
  String? choosedCurrency;

  @override
  void initState() {
    super.initState();
    asyncInit();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future asyncInit() async {
    
    final result = fetchCurrencyRates();
    print(result);
  }
  // fetchCurrencyRates

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Currency Converter'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: amountController,
              decoration: const InputDecoration(
                labelText: 'Amount',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            DropdownButton<String>(
              isExpanded: true,
              items: currencies.map((String currency) {
                return DropdownMenuItem<String>(
                  value: currency,
                  child: Text(currency),
                );
              }).toList(),
              onChanged: (String? selectedCurrency) {
                setState(() {
                  choosedCurrency = selectedCurrency;
                });
              },
              hint: Text(choosedCurrency == null || choosedCurrency!.isEmpty ? 'Select Currency' : choosedCurrency!),
            ),
          ],
        ),
      ),
    );
  }
}
