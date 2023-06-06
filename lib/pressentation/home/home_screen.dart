import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:recipes_app/pressentation/random_recipe/random_recipe_screen.dart';
import 'package:recipes_app/pressentation/saved_recipes/saved_recipes_screen.dart';
import 'package:recipes_app/pressentation/search_recipe/search_recipe__screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int _index = 1;

  List<Widget> _screens = [
    RandomRecipeScreen(),
    SearchRecipeScreen(),
    SavedRecipesScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //extendBody: true,
      body: _screens[_index],
      bottomNavigationBar: FloatingNavbar(
        selectedItemColor: Color(0xffF4AA39),

        onTap: (int val) => setState(() => _index = val),
        currentIndex: _index,
        items: [
          FloatingNavbarItem(icon: Icons.question_mark_outlined, title: 'Random Recipe'),
          FloatingNavbarItem(icon: Icons.search, title: 'Search'),
          FloatingNavbarItem(icon: Icons.book_rounded, title: 'Saved Recipes'),
        ],
        backgroundColor: Color(0xffF4AA39),
      ),
    );
  }

}


