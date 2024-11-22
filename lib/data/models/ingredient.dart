class Ingredient {
  final int? id;
  final int? recipeId;
  final String? name;
  final double? quantity;

  Ingredient({
    this.id,
    this.recipeId,
    this.name,
    this.quantity,
  });

  Ingredient copyWith({
    int? id,
    int? recipeId,
    String? name,
    double? quantity,
  }) {
    return Ingredient(
      id: id ?? this.id,
      recipeId: recipeId ?? this.recipeId,
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
    );
  }
}