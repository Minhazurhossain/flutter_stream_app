import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'ui/bookmarks/bookmarks.dart';
import 'ui/groceries/groceries.dart';

void main() {
  runApp(
    const ProviderScope(
      child: RecipeApp(),
    ),
  );
}

class RecipeApp extends StatelessWidget {
  const RecipeApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipe App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const DefaultTabController(
        length: 2,
        child: Scaffold(
          body: TabBarView(
            children: [
              BookmarksScreen(),
              GroceriesScreen(),
            ],
          ),
          bottomNavigationBar: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.book), text: 'Bookmarks'),
              Tab(icon: Icon(Icons.shopping_cart), text: 'Groceries'),
            ],
          ),
        ),
      ),
    );
  }
}