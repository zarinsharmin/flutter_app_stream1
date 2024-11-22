import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'ui/bookmarks/bookmarks.dart';
import 'ui/groceries/groceries.dart';
import 'data/repositories/memory_repository.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => MemoryRepository(),
      child: MaterialApp(
        title: 'Flutter Streams Example',
        initialRoute: '/',
        routes: {
          '/': (context) => BookmarksScreen(),
          '/groceries': (context) => GroceriesScreen(),
        },
      ),
    );
  }
}
