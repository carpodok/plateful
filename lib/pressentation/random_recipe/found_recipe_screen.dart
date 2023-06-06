import 'package:flutter/material.dart';
import 'package:recipes_app/pressentation/random_recipe/random_recipe_screen.dart';

import '../../domain/entities/ingredient.dart';
import '../../domain/entities/recipe_detail.dart';

class FoundRecipeScreen extends StatefulWidget {
  final RecipeDetail recipeDetail;

  const FoundRecipeScreen({Key? key, required this.recipeDetail})
      : super(key: key);

  @override
  State<FoundRecipeScreen> createState() => _FoundRecipeScreenState();
}

class _FoundRecipeScreenState extends State<FoundRecipeScreen> {
  late final randomRecipe;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    randomRecipe = widget.recipeDetail;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),

            ),
            child: Container(
              height: screenWidth,
              child: Image.network(
                randomRecipe.image,
                // Replace with your own image URL
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(randomRecipe.title),
          SizedBox(
            height: 10,
          ),
          Text("Recipe"),
          Text(randomRecipe.summary),
          Expanded(
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: randomRecipe.ingredients.length,
                  itemBuilder: (BuildContext context, int index) {
                    final ingredient = Ingredient();
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: _ingredientsListItem(ingredient),
                    );
                  })),
          
          Padding(
            padding: const EdgeInsets.only(bottom: 80),
            child: ElevatedButton(onPressed: _onAgainButtonPressed(), child: Text("Again?")),
          )
        ],
      ),
    );
  }

  Widget _ingredientsListItem(Ingredient ingredient) {
    return Card();
  }

  _onAgainButtonPressed() {}
}
