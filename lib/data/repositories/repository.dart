import 'package:stream_lab/data/models/recipe.dart';
import 'package:stream_lab/data/models/ingredient.dart';

abstract class Repository {
  Stream<List<Recipe>> watchAllRecipes();
  Stream<List<Ingredient>> watchAllIngredients();
  Future<int> insertRecipe(Recipe recipe);
  Future<int> insertIngredient(Ingredient ingredient);
}
