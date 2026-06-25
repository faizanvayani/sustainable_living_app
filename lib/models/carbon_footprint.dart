class CarbonFootprint {
  final int? id;
  final int userId;
  final String date;
  final double transportation;
  final double energyUsage;
  final double foodConsumption;
  final double totalFootprint;

  CarbonFootprint({
    this.id,
    required this.userId,
    required this.date,
    required this.transportation,
    required this.energyUsage,
    required this.foodConsumption,
    required this.totalFootprint,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': userId,
      'date': date,
      'transportation': transportation,
      'energy_usage': energyUsage,
      'food_consumption': foodConsumption,
      'total_footprint': totalFootprint,
    };
  }

  factory CarbonFootprint.fromMap(Map<String, dynamic> map) {
    return CarbonFootprint(
      id: map['id'] as int?,
      userId: map['user_id'] as int,
      date: map['date'] as String,
      transportation: (map['transportation'] as num).toDouble(),
      energyUsage: (map['energy_usage'] as num).toDouble(),
      foodConsumption: (map['food_consumption'] as num).toDouble(),
      totalFootprint: (map['total_footprint'] as num).toDouble(),
    );
  }
}
