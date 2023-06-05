import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipes_app/pressentation/home/home_screen.dart';
import 'package:recipes_app/pressentation/random_recipe/random_recipe_sceen_view_model.dart';
import 'package:recipes_app/pressentation/search_recipe/search_recipe_screen_view_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => SearchRecipeScreenViewModel()),
        ChangeNotifierProvider(create: (context) => RandomRecipeViewModel()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomeScreen(),
      ),
    );
  }
}
