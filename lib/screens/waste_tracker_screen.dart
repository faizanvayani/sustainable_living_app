import 'package:flutter/material.dart';
import '../database/database_helper.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';

class WasteTrackerScreen extends StatefulWidget {
  const WasteTrackerScreen({super.key});

  @override
  State<WasteTrackerScreen> createState() => _WasteTrackerScreenState();
}

class _WasteTrackerScreenState extends State<WasteTrackerScreen> {
  final _formKey = GlobalKey<FormState>();
  final _quantityController = TextEditingController();
  String _selectedWasteType = 'Plastic';
  bool _isRecycled = false;
  List<Map<String, dynamic>> _history = [];

  final List<String> _wasteTypes = ['Plastic', 'Paper', 'Glass', 'Organic', 'Metal', 'Electronic'];

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  @override
  void dispose() {
    _quantityController.dispose();
    super.dispose();
  }

  Future<void> _loadHistory() async {
    final user = Provider.of<UserProvider>(context, listen: false).currentUser;
    if (user != null) {
      final history = await DatabaseHelper.instance.getWasteHistory(user.id!);
      setState(() => _history = history);
    }
  }

  Future<void> _addEntry() async {
    if (_formKey.currentState!.validate()) {
      final user = Provider.of<UserProvider>(context, listen: false).currentUser;
      if (user != null) {
        await DatabaseHelper.instance.addWasteEntry(
          userId: user.id!,
          date: DateTime.now().toIso8601String().split('T')[0],
          wasteType: _selectedWasteType,
          quantity: double.parse(_quantityController.text),
          recycled: _isRecycled,
        );
        
        _quantityController.clear();
        setState(() => _isRecycled = false);
        _loadHistory();
        
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Waste entry added!'), backgroundColor: Colors.green),
          );
        }
      }
    }
  }

  Color _getWasteColor(String type) {
    switch (type) {
      case 'Plastic': return Colors.blue;
      case 'Paper': return Colors.brown;
      case 'Glass': return Colors.cyan;
      case 'Organic': return Colors.green;
      case 'Metal': return Colors.grey;
      case 'Electronic': return Colors.red;
      default: return Colors.grey;
    }
  }

  IconData _getWasteIcon(String type) {
    switch (type) {
      case 'Plastic': return Icons.recycling;
      case 'Paper': return Icons.description;
      case 'Glass': return Icons.local_drink;
      case 'Organic': return Icons.grass;
      case 'Metal': return Icons.battery_std;
      case 'Electronic': return Icons.devices;
      default: return Icons.delete;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Waste Tracker'),
        backgroundColor: const Color(0xFF4CAF50),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Log Waste Entry', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 16),
                      DropdownButtonFormField<String>(
                        value: _selectedWasteType,
                        decoration: const InputDecoration(
                          labelText: 'Waste Type',
                          prefixIcon: Icon(Icons.delete),
                        ),
                        items: _wasteTypes.map((type) {
                          return DropdownMenuItem(value: type, child: Text(type));
                        }).toList(),
                        onChanged: (value) => setState(() => _selectedWasteType = value!),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _quantityController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Quantity (kg)',
                          prefixIcon: Icon(Icons.scale),
                        ),
                        validator: (v) => v!.isEmpty ? 'Enter quantity' : null,
                      ),
                      const SizedBox(height: 16),
                      SwitchListTile(
                        title: const Text('Recycled?'),
                        value: _isRecycled,
                        onChanged: (v) => setState(() => _isRecycled = v),
                        activeColor: const Color(0xFF4CAF50),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _addEntry,
                          child: const Text('Add Entry'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text('History', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _history.length,
              itemBuilder: (context, index) {
                final entry = _history[index];
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: _getWasteColor(entry['waste_type']).withOpacity(0.2),
                      child: Icon(_getWasteIcon(entry['waste_type']), color: _getWasteColor(entry['waste_type'])),
                    ),
                    title: Text('${entry['waste_type']} - ${entry['quantity']} kg'),
                    subtitle: Text(entry['date']),
                    trailing: entry['recycled'] == 1 
                      ? const Icon(Icons.check_circle, color: Colors.green)
                      : const Icon(Icons.cancel, color: Colors.red),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
