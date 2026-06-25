class Challenge {
  final int? id;
  final String challengeName;
  final String? description;
  final int duration;
  final String difficulty;
  final int points;

  Challenge({
    this.id,
    required this.challengeName,
    this.description,
    required this.duration,
    required this.difficulty,
    required this.points,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'challenge_name': challengeName,
      'description': description,
      'duration': duration,
      'difficulty': difficulty,
      'points': points,
    };
  }

  factory Challenge.fromMap(Map<String, dynamic> map) {
    return Challenge(
      id: map['id'] as int?,
      challengeName: map['challenge_name'] as String,
      description: map['description'] as String?,
      duration: map['duration'] as int,
      difficulty: map['difficulty'] as String,
      points: map['points'] as int,
    );
  }
}
