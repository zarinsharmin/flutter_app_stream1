import 'package:stream_lab/data/models/ingredient.dart';

class Recipe {
  final int id;
  final String name;
  final List<Ingredient> ingredients;

  Recipe({required this.id, required this.name, required this.ingredients});
}
