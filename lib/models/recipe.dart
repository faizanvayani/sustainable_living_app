class Recipe {
  final int? id;
  final String recipeName;
  final String category;
  final String? ingredients;
  final String? instructions;
  final String carbonImpact;
  final String? imageUrl;

  Recipe({
    this.id,
    required this.recipeName,
    required this.category,
    this.ingredients,
    this.instructions,
    required this.carbonImpact,
    this.imageUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'recipe_name': recipeName,
      'category': category,
      'ingredients': ingredients,
      'instructions': instructions,
      'carbon_impact': carbonImpact,
      'image_url': imageUrl,
    };
  }

  factory Recipe.fromMap(Map<String, dynamic> map) {
    return Recipe(
      id: map['id'] as int?,
      recipeName: map['recipe_name'] as String,
      category: map['category'] as String,
      ingredients: map['ingredients'] as String?,
      instructions: map['instructions'] as String?,
      carbonImpact: map['carbon_impact'] as String,
      imageUrl: map['image_url'] as String?,
    );
  }
}
