// lib/models/product.dart
class Product {
  final String id;
  final String name;
  final String brand;
  final String nutriscore;
  final int calories;
  final double fat;
  final double sugars;
  final double salt;
  final double carbohydrates; // NUOVO CAMPO
  final double proteins; // NUOVO CAMPO
  final double price;
  final String image;
  final String category;

  Product({
    required this.id,
    required this.name,
    required this.brand,
    required this.nutriscore,
    required this.calories,
    required this.fat,
    required this.sugars,
    required this.salt,
    required this.carbohydrates, // NUOVO PARAMETRO
    required this.proteins, // NUOVO PARAMETRO
    required this.price,
    required this.image,
    required this.category,
  });

  factory Product.fromMap(Map<String, dynamic> map, String id, String category) {
    return Product(
      id: id,
      name: map['name'] as String,
      brand: map['brand'] as String,
      nutriscore: map['nutriscore'] as String,
      calories: map['calories'] as int,
      fat: (map['fat'] as num).toDouble(),
      sugars: (map['sugars'] as num).toDouble(),
      salt: (map['salt'] as num).toDouble(),
      carbohydrates: (map['carbohydrates'] as num?)?.toDouble() ?? 0.0, // Assicurati che non sia null
      proteins: (map['proteins'] as num?)?.toDouble() ?? 0.0, // Assicurati che non sia null
      price: (map['price'] as num).toDouble(),
      image: map['image'] as String,
      category: category,
    );
  }
}