import 'ingredient.dart';

class Recipe {
  final int? id;
  final String? label;
  final String? image;
  final List<Ingredient> ingredients;

  Recipe({
    this.id,
    this.label,
    this.image,
    this.ingredients = const [],
  });

  Recipe copyWith({
    int? id,
    String? label,
    String? image,
    List<Ingredient>? ingredients,
  }) {
    return Recipe(
      id: id ?? this.id,
      label: label ?? this.label,
      image: image ?? this.image,
      ingredients: ingredients ?? this.ingredients,
    );
  }
}