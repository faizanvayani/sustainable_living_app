class EcoProduct {
  final int? id;
  final String productName;
  final String category;
  final String? description;
  final String? imageUrl;
  final double price;
  final double rating;
  final String createdAt;

  EcoProduct({
    this.id,
    required this.productName,
    required this.category,
    this.description,
    this.imageUrl,
    required this.price,
    required this.rating,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'product_name': productName,
      'category': category,
      'description': description,
      'image_url': imageUrl,
      'price': price,
      'rating': rating,
      'created_at': createdAt,
    };
  }

  factory EcoProduct.fromMap(Map<String, dynamic> map) {
    return EcoProduct(
      id: map['id'] as int?,
      productName: map['product_name'] as String,
      category: map['category'] as String,
      description: map['description'] as String?,
      imageUrl: map['image_url'] as String?,
      price: (map['price'] as num).toDouble(),
      rating: (map['rating'] as num).toDouble(),
      createdAt: map['created_at'] as String,
    );
  }
}
