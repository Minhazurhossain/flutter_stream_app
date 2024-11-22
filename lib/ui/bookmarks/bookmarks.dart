import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/recipe.dart';
import '../../data/repositories/memory_repository.dart';

// Create a provider for the repository
final repositoryProvider = StateNotifierProvider<RepositoryNotifier, RepositoryState>((ref) {
  return RepositoryNotifier();
});

class BookmarksScreen extends ConsumerStatefulWidget {
  const BookmarksScreen({Key? key}) : super(key: key);

  @override
  _BookmarksScreenState createState() => _BookmarksScreenState();
}

class _BookmarksScreenState extends ConsumerState<BookmarksScreen> {
  late Stream<List<Recipe>> recipeStream;
  List<Recipe> recipes = [];

  @override
  void initState() {
    super.initState();
    final repository = ref.read(repositoryProvider.notifier);
    recipeStream = repository.watchAllRecipes();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Recipe>>(
      stream: recipeStream,
      builder: (context, AsyncSnapshot<List<Recipe>> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          recipes = snapshot.data ?? [];
        }
        return Scaffold(
          appBar: AppBar(title: const Text('Bookmarks')),
          body: ListView.builder(
            itemCount: recipes.length,
            itemBuilder: (context, index) {
              final recipe = recipes[index];
              return ListTile(
                title: Text(recipe.label ?? 'Unnamed Recipe'),
                subtitle: Text('${recipe.ingredients.length} ingredients'),
              );
            },
          ),
        );
      },
    );
  }
}