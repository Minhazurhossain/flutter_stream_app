import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/ingredient.dart';
import '../bookmarks/bookmarks.dart'; // Import the repositoryProvider

class GroceriesScreen extends ConsumerStatefulWidget {
  const GroceriesScreen({Key? key}) : super(key: key);

  @override
  _GroceriesScreenState createState() => _GroceriesScreenState();
}

class _GroceriesScreenState extends ConsumerState<GroceriesScreen> {
  List<Ingredient> currentIngredients = [];
  List<Ingredient> searchIngredients = [];
  bool searching = false;

  @override
  void initState() {
    super.initState();
    final repository = ref.read(repositoryProvider.notifier);
    final ingredientStream = repository.watchAllIngredients();
    ingredientStream.listen(
      (ingredients) {
        setState(() {
          currentIngredients = ingredients;
        });
      },
    );
  }

  void startSearch(String searchString) {
    searching = searchString.isNotEmpty;
    searchIngredients = currentIngredients
      .where((element) => true == element.name?.contains(searchString))
      .toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Groceries'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Search ingredients',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: startSearch,
            ),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: searching ? searchIngredients.length : currentIngredients.length,
        itemBuilder: (context, index) {
          final ingredient = searching ? searchIngredients[index] : currentIngredients[index];
          return ListTile(
            title: Text(ingredient.name ?? 'Unnamed Ingredient'),
            subtitle: Text('Quantity: ${ingredient.quantity ?? 0}'),
          );
        },
      ),
    );
  }
}