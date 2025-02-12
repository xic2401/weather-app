import 'package:flutter/material.dart';
import 'package:weather_app/models/currency.dart';
import 'package:weather_app/services/services_currency.dart';
import 'package:flutter/services.dart';

class ConverterScreen extends StatefulWidget {
  const ConverterScreen({super.key});

  @override
  ConverterScreenState createState() => ConverterScreenState();
}

class ConverterScreenState extends State<ConverterScreen> {
  final TextEditingController amountController = TextEditingController();
  List<Currency> currencies = [];
  double kgsRate = 0;
  Currency? choosedCurrency;

  @override
  void initState() {
    super.initState();
    amountController.text = '100';
    asyncInit();
  }

  @override
  void dispose() {
    amountController.dispose();
    super.dispose();
  }

  Future asyncInit() async {
    List<Currency> result = await fetchCurrencyRates();
    setState(() {
      currencies = result;
      kgsRate =
          currencies.firstWhere((item) => item.name == 'KGS').exchangeRate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: AppBar(
          title: const Text('Курс Валют'),
          backgroundColor: Colors.deepPurple,
          centerTitle: true,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Column(
          spacing: 25,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Введите сумму для конвертации:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple[700],
              ),
            ),
            TextField(
              controller: amountController,
              decoration: const InputDecoration(
                labelText: 'Сумма',
                border: OutlineInputBorder(),
                suffixText: 'KGS',
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Выберите валюту для конвертации:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 56, 105, 78),
              ),
            ),
            DropdownButton<Currency>(
              isExpanded: true,
              value: choosedCurrency,
              items: currencies.map((Currency currency) {
                return DropdownMenuItem<Currency>(
                  value: currency,
                  child: Text(currency.name),
                );
              }).toList(),
              onChanged: (Currency? selectedCurrency) {
                setState(() {
                  choosedCurrency = selectedCurrency;
                });
              },
              hint: Text('Выберите валюту'),
              style: TextStyle(
                color: Colors.deepPurple[600],
                fontWeight: FontWeight.bold,
              ),
              dropdownColor: Colors.deepPurple[50],
            ),
            SizedBox(height: 30),
            if (choosedCurrency != null && amountController.text.isNotEmpty)
              Text(
                'Результат: ${(double.parse(amountController.text) * kgsRate / choosedCurrency!.exchangeRate).toStringAsFixed(2)} ${choosedCurrency!.name}',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple[700],
                  letterSpacing: 2,
                ),
              ),
            if (choosedCurrency == null && amountController.text.isNotEmpty)
              Text(
                'Пожалуйста, выберите валюту для конвертации.',
                style: TextStyle(
                  fontSize: 18,
                  color: const Color.fromARGB(255, 233, 31, 31),
                  fontWeight: FontWeight.bold,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
