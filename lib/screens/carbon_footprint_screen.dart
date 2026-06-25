import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../database/database_helper.dart';
import '../models/carbon_footprint.dart';
import '../providers/user_provider.dart';
import 'package:intl/intl.dart';

class CarbonFootprintScreen extends StatefulWidget {
  const CarbonFootprintScreen({super.key});

  @override
  State<CarbonFootprintScreen> createState() => _CarbonFootprintScreenState();
}

class _CarbonFootprintScreenState extends State<CarbonFootprintScreen> {
  final _formKey = GlobalKey<FormState>();
  final _transportController = TextEditingController();
  final _energyController = TextEditingController();
  final _foodController = TextEditingController();
  double _totalFootprint = 0;
  String _recommendation = '';
  List<CarbonFootprint> _history = [];

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  @override
  void dispose() {
    _transportController.dispose();
    _energyController.dispose();
    _foodController.dispose();
    super.dispose();
  }

  Future<void> _loadHistory() async {
    final user = Provider.of<UserProvider>(context, listen: false).currentUser;
    if (user != null) {
      final history = await DatabaseHelper.instance.getCarbonFootprintHistory(user.id!);
      setState(() => _history = history);
    }
  }

  void _calculateFootprint() {
    if (_formKey.currentState!.validate()) {
      final transport = double.parse(_transportController.text);
      final energy = double.parse(_energyController.text);
      final food = double.parse(_foodController.text);
      final total = transport + energy + food;

      setState(() {
        _totalFootprint = total;
        _recommendation = _generateRecommendation(total, transport, energy, food);
      });

      _saveFootprint(transport, energy, food, total);
    }
  }

  String _generateRecommendation(double total, double transport, double energy, double food) {
    String tips = 'Recommendations:\n\n';

    if (transport > 10) {
      tips += '🚗 Consider carpooling or using public transport\n';
    }
    if (energy > 15) {
      tips += '💡 Switch to LED bulbs and unplug unused devices\n';
    }
    if (food > 8) {
      tips += '🥗 Try incorporating more plant-based meals\n';
    }
    if (total < 20) {
      tips += '✅ Great job! You\'re doing well!\n';
    } else if (total < 35) {
      tips += '📊 Average footprint. You can do better!\n';
    } else {
      tips += '⚠️ High footprint. Consider making changes!\n';
    }

    return tips;
  }

  Future<void> _saveFootprint(double transport, double energy, double food, double total) async {
    final user = Provider.of<UserProvider>(context, listen: false).currentUser;
    if (user != null) {
      final footprint = CarbonFootprint(
        userId: user.id!,
        date: DateTime.now().toIso8601String().split('T')[0],
        transportation: transport,
        energyUsage: energy,
        foodConsumption: food,
        totalFootprint: total,
      );

      await DatabaseHelper.instance.addCarbonFootprint(footprint);
      _loadHistory();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Carbon footprint saved!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carbon Footprint Tracker'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Calculate Your Daily Carbon Footprint',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _transportController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Transportation (kg CO2)',
                          prefixIcon: Icon(Icons.directions_car),
                          hintText: 'e.g., 10.5',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a value';
                          }
                          if (double.tryParse(value) == null) {
                            return 'Please enter a valid number';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _energyController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Energy Usage (kg CO2)',
                          prefixIcon: Icon(Icons.bolt),
                          hintText: 'e.g., 15.2',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a value';
                          }
                          if (double.tryParse(value) == null) {
                            return 'Please enter a valid number';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _foodController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Food Consumption (kg CO2)',
                          prefixIcon: Icon(Icons.restaurant),
                          hintText: 'e.g., 7.8',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a value';
                          }
                          if (double.tryParse(value) == null) {
                            return 'Please enter a valid number';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: _calculateFootprint,
                        child: const Text('Calculate Footprint'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (_totalFootprint > 0) ...[
              const SizedBox(height: 16),
              Card(
                color: _totalFootprint < 20
                    ? Colors.green.shade50
                    : _totalFootprint < 35
                        ? Colors.orange.shade50
                        : Colors.red.shade50,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text(
                        'Your Carbon Footprint',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${_totalFootprint.toStringAsFixed(2)} kg CO2',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        _recommendation,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),
            ],
            if (_history.isNotEmpty) ...[
              const SizedBox(height: 24),
              const Text(
                'History',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _history.length,
                itemBuilder: (context, index) {
                  final entry = _history[index];
                  return Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Theme.of(context).primaryColor,
                        child: Text(
                          entry.totalFootprint.toStringAsFixed(0),
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      title: Text(
                        DateFormat('MMM dd, yyyy').format(
                          DateTime.parse(entry.date),
                        ),
                      ),
                      subtitle: Text(
                        'Transport: ${entry.transportation.toStringAsFixed(1)} | '
                        'Energy: ${entry.energyUsage.toStringAsFixed(1)} | '
                        'Food: ${entry.foodConsumption.toStringAsFixed(1)}',
                      ),
                      trailing: Text(
                        '${entry.totalFootprint.toStringAsFixed(2)} kg',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ],
        ),
      ),
    );
  }
}
