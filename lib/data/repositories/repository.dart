import '../models/recipe.dart';
import '../models/ingredient.dart';

abstract class Repository {
  Stream<List<Recipe>> watchAllRecipes();
  Stream<List<Ingredient>> watchAllIngredients();
  
  Future<int> insertRecipe(Recipe recipe);
  Future<int> insertIngredients(List<Ingredient> ingredients);
}