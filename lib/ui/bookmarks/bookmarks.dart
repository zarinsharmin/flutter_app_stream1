import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/repositories/memory_repository.dart';
import '../../data/models/recipe.dart';

class BookmarksScreen extends StatefulWidget {
  const BookmarksScreen({super.key});

  @override
  _BookmarksScreenState createState() => _BookmarksScreenState();
}

class _BookmarksScreenState extends State<BookmarksScreen> {
  late Stream<List<Recipe>> recipeStream;

  @override
  void initState() {
    super.initState();
    final repository = context.read<MemoryRepository>();
    recipeStream = repository.watchAllRecipes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bookmarks')),
      body: StreamBuilder<List<Recipe>>(
        stream: recipeStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No recipes found'));
          }

          final recipes = snapshot.data!;
          return ListView.builder(
            itemCount: recipes.length,
            itemBuilder: (context, index) {
              final recipe = recipes[index];
              return ListTile(title: Text(recipe.name));
            },
          );
        },
      ),
    );
  }
}
