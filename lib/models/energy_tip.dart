class EnergyTip {
  final int? id;
  final String tipTitle;
  final String? tipContent;
  final String category;
  final String savingsPotential;

  EnergyTip({
    this.id,
    required this.tipTitle,
    this.tipContent,
    required this.category,
    required this.savingsPotential,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'tip_title': tipTitle,
      'tip_content': tipContent,
      'category': category,
      'savings_potential': savingsPotential,
    };
  }

  factory EnergyTip.fromMap(Map<String, dynamic> map) {
    return EnergyTip(
      id: map['id'] as int?,
      tipTitle: map['tip_title'] as String,
      tipContent: map['tip_content'] as String?,
      category: map['category'] as String,
      savingsPotential: map['savings_potential'] as String,
    );
  }
}
