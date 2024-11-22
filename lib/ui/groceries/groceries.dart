import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/repositories/memory_repository.dart';
import '../../data/models/ingredient.dart';

class GroceriesScreen extends StatefulWidget {
  const GroceriesScreen({super.key});

  @override
  _GroceriesScreenState createState() => _GroceriesScreenState();
}

class _GroceriesScreenState extends State<GroceriesScreen> {
  List<Ingredient> currentIngredients = [];
  bool searching = false;
  List<Ingredient> searchIngredients = [];

  @override
  void initState() {
    super.initState();
    final repository = context.read<MemoryRepository>();
    repository.watchAllIngredients().listen((ingredients) {
      setState(() {
        currentIngredients = ingredients;
      });
    });
  }

  void startSearch(String searchString) {
    setState(() {
      searching = searchString.isNotEmpty;
      searchIngredients = currentIngredients
          .where((element) => element.name.contains(searchString))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Groceries'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate:
                    IngredientSearchDelegate(startSearch, searchIngredients),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount:
            searching ? searchIngredients.length : currentIngredients.length,
        itemBuilder: (context, index) {
          final ingredient =
              searching ? searchIngredients[index] : currentIngredients[index];
          return ListTile(title: Text(ingredient.name));
        },
      ),
    );
  }
}

class IngredientSearchDelegate extends SearchDelegate {
  final Function(String) onSearch;
  final List<Ingredient> searchIngredients;

  IngredientSearchDelegate(this.onSearch, this.searchIngredients);

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = searchIngredients
        .where((ingredient) => ingredient.name.contains(query))
        .toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(suggestions[index].name),
          onTap: () {
            close(context, suggestions[index]);
          },
        );
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container(); // Implement search results logic
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }
}
