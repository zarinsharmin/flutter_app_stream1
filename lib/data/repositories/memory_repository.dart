import 'dart:async';
import '../models/recipe.dart';
import '../models/ingredient.dart';
import 'package:stream_lab/data/repositories/repository.dart';

class MemoryRepository implements Repository {
  late final Stream<List<Recipe>> _recipeStream;
  late final Stream<List<Ingredient>> _ingredientStream;

  final StreamController<List<Recipe>> _recipeStreamController =
      StreamController<List<Recipe>>.broadcast();
  final StreamController<List<Ingredient>> _ingredientStreamController =
      StreamController<List<Ingredient>>.broadcast();

  MemoryRepository() {
    _recipeStream = _recipeStreamController.stream;
    _ingredientStream = _ingredientStreamController.stream;
  }

  @override
  Stream<List<Recipe>> watchAllRecipes() => _recipeStream;

  @override
  Stream<List<Ingredient>> watchAllIngredients() => _ingredientStream;

  @override
  // Now returns Future<int> instead of Future<void>
  Future<int> insertRecipe(Recipe recipe) async {
    // Get the current list of recipes
    List<Recipe> recipes = await _recipeStreamController.stream.last;

    // Add the new recipe to the list
    _recipeStreamController.sink.add([...recipes, recipe]);

    // Return an integer (e.g., 1 for success, or some logic to return an ID)
    return 1; // Replace with actual logic if needed
  }

  @override
  // Now returns Future<int> instead of Future<void>
  Future<int> insertIngredient(Ingredient ingredient) async {
    // Get the current list of ingredients
    List<Ingredient> ingredients =
        await _ingredientStreamController.stream.last;

    // Add the new ingredient to the list
    _ingredientStreamController.sink.add([...ingredients, ingredient]);

    // Return an integer (e.g., 1 for success, or some logic to return an ID)
    return 1; // Replace with actual logic if needed
  }

  void dispose() {
    _recipeStreamController.close();
    _ingredientStreamController.close();
  }
}


// 