import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/recipe.dart';
import '../models/ingredient.dart';

class RepositoryNotifier extends StateNotifier<RepositoryState> {
  RepositoryNotifier() : super(RepositoryState()) {
    _initializeStreams();
  }

  final StreamController<List<Recipe>> _recipeStreamController = StreamController<List<Recipe>>.broadcast();
  final StreamController<List<Ingredient>> _ingredientStreamController = StreamController<List<Ingredient>>.broadcast();

  void _initializeStreams() {
    _recipeStreamController.add(state.currentRecipes);
    _ingredientStreamController.add(state.currentIngredients);
  }

  Stream<List<Recipe>> watchAllRecipes() {
    return _recipeStreamController.stream;
  }

  Stream<List<Ingredient>> watchAllIngredients() {
    return _ingredientStreamController.stream;
  }

  Future<int> insertRecipe(Recipe recipe) {
    if (state.currentRecipes.contains(recipe)) {
      return Future.value(0);
    }
    
    final updatedRecipes = [...state.currentRecipes, recipe];
    state = state.copyWith(currentRecipes: updatedRecipes);
    _recipeStreamController.add(updatedRecipes);
    
    final ingredients = <Ingredient>[];
    for (final ingredient in recipe.ingredients) {
      ingredients.add(ingredient.copyWith(recipeId: recipe.id));
    }
    insertIngredients(ingredients);
    return Future.value(0);
  }

  Future<int> insertIngredients(List<Ingredient> ingredients) {
    final updatedIngredients = [...state.currentIngredients, ...ingredients];
    state = state.copyWith(currentIngredients: updatedIngredients);
    _ingredientStreamController.add(updatedIngredients);
    return Future.value(0);
  }
}

class RepositoryState {
  final List<Recipe> currentRecipes;
  final List<Ingredient> currentIngredients;

  RepositoryState({
    this.currentRecipes = const [],
    this.currentIngredients = const [],
  });

  RepositoryState copyWith({
    List<Recipe>? currentRecipes,
    List<Ingredient>? currentIngredients,
  }) {
    return RepositoryState(
      currentRecipes: currentRecipes ?? this.currentRecipes,
      currentIngredients: currentIngredients ?? this.currentIngredients,
    );
  }
}