import 'package:flutter/material.dart';
import '../database/database_helper.dart';
import '../models/energy_tip.dart';

class EnergyTipsScreen extends StatefulWidget {
  const EnergyTipsScreen({super.key});

  @override
  State<EnergyTipsScreen> createState() => _EnergyTipsScreenState();
}

class _EnergyTipsScreenState extends State<EnergyTipsScreen> {
  List<EnergyTip> _tips = [];
  bool _isLoading = true;
  String _selectedCategory = 'All';

  final List<String> _categories = [
    'All',
    'Lighting',
    'Heating/Cooling',
    'Appliances',
    'General',
  ];

  @override
  void initState() {
    super.initState();
    _loadTips();
  }

  Future<void> _loadTips() async {
    setState(() => _isLoading = true);
    final tips = await DatabaseHelper.instance.getAllEnergyTips();
    setState(() {
      _tips = tips;
      _isLoading = false;
    });
  }

  List<EnergyTip> get _filteredTips {
    if (_selectedCategory == 'All') return _tips;
    return _tips.where((tip) => tip.category == _selectedCategory).toList();
  }

  Color _getSavingsColor(String potential) {
    switch (potential.toLowerCase()) {
      case 'high':
        return Colors.green;
      case 'medium':
        return Colors.orange;
      case 'low':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  IconData _getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'lighting':
        return Icons.lightbulb;
      case 'heating/cooling':
        return Icons.thermostat;
      case 'appliances':
        return Icons.electrical_services;
      default:
        return Icons.tips_and_updates;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Energy Conservation Tips'),
        backgroundColor: const Color(0xFF4CAF50),
      ),
      body: Column(
        children: [
          // Category Filter
          Container(
            height: 60,
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                final category = _categories[index];
                final isSelected = _selectedCategory == category;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: Text(category),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() => _selectedCategory = category);
                    },
                    selectedColor: const Color(0xFF4CAF50).withOpacity(0.3),
                    checkmarkColor: const Color(0xFF4CAF50),
                  ),
                );
              },
            ),
          ),

          // Tips List
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _filteredTips.isEmpty
                    ? const Center(child: Text('No tips available'))
                    : ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: _filteredTips.length,
                        itemBuilder: (context, index) {
                          final tip = _filteredTips[index];
                          return _buildTipCard(tip);
                        },
                      ),
          ),
        ],
      ),
    );
  }

  Widget _buildTipCard(EnergyTip tip) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF4CAF50).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    _getCategoryIcon(tip.category),
                    color: const Color(0xFF4CAF50),
                    size: 28,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tip.tipTitle,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: _getSavingsColor(tip.savingsPotential)
                              .withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          '${tip.savingsPotential} Savings',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: _getSavingsColor(tip.savingsPotential),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              tip.tipContent ?? '',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
                height: 1.5,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(
                  Icons.category,
                  size: 16,
                  color: Colors.grey[600],
                ),
                const SizedBox(width: 4),
                Text(
                  tip.category,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
