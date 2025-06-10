import 'package:flutter/material.dart';

void main() {
  runApp(PriceCalculatorApp());
}

class PriceCalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Price Calculator',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: PriceCalculatorScreen(),
    );
  }
}

class PriceCalculatorScreen extends StatefulWidget {
  @override
  _PriceCalculatorScreenState createState() => _PriceCalculatorScreenState();
}

class _PriceCalculatorScreenState extends State<PriceCalculatorScreen> {
  final TextEditingController _qualityController = TextEditingController();
  final TextEditingController _cutLengthController = TextEditingController();
  final TextEditingController _costPriceController = TextEditingController();

  double? _price;
  double? _weight;
  double? _gsm;

  static const double SQINCHSQM = 1550;
  static const double WIDTH = 90;
  static const double MIS_VAR = 25;
  static const double WASTE = 1;
  static const double STANDARD_CUT = 60;

  void calculatePrice() {
    final double? quality = double.tryParse(_qualityController.text);
    final double? cutLength = double.tryParse(_cutLengthController.text);
    final double? costPrice = double.tryParse(_costPriceController.text);

    if (quality == null || cutLength == null || costPrice == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter valid numbers')),
      );
      return;
    }

    final double area = cutLength * WIDTH * 2;
    final double areasqm = area / SQINCHSQM;
    final double standardArea = STANDARD_CUT * WIDTH;
    final double standardAreaSqm = standardArea / SQINCHSQM;
    final double gsm = quality / standardAreaSqm;
    double weight = gsm * areasqm;
    weight = weight + ((weight * WASTE) / 100);
    final double cost = (weight * costPrice) / 1000;
    final double price = cost + MIS_VAR;

    setState(() {
      _price = price;
      _weight = weight;
      _gsm = gsm;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Price Calculator')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _qualityController,
              decoration: InputDecoration(labelText: 'Quality'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _cutLengthController,
              decoration: InputDecoration(labelText: 'Cut Length'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _costPriceController,
              decoration: InputDecoration(labelText: 'Cost Price'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: calculatePrice,
              child: Text('Calculate'),
            ),
            SizedBox(height: 20),
            if (_price != null) ...[
              Text('Price: ₹${_price!.toStringAsFixed(2)}'),
              Text('Weight: ${_weight!.toStringAsFixed(2)} g'),
              Text('GSM: ${_gsm!.toStringAsFixed(2)}'),
            ],
          ],
        ),
      ),
    );
  }
}
