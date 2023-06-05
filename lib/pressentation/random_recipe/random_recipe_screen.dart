import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipes_app/data/models/remote/random_recipe_response.dart';
import 'package:recipes_app/domain/entities/ingredient.dart';
import 'package:recipes_app/domain/entities/recipe_detail.dart';
import 'package:recipes_app/pressentation/random_recipe/found_recipe_screen.dart';
import 'package:recipes_app/pressentation/random_recipe/random_recipe_sceen_view_model.dart';

import '../../utils/view_state.dart';
import '../widgets/loading_screen.dart';

class RandomRecipeScreen extends StatefulWidget {
  const RandomRecipeScreen({Key? key}) : super(key: key);

  @override
  State<RandomRecipeScreen> createState() => _RandomRecipeScreenState();
}

class _RandomRecipeScreenState extends State<RandomRecipeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<RandomRecipeViewModel>(builder: (context, viewModel, _) {
        switch (viewModel.randomRecipeResponseState.state) {
          case ResponseState.LOADING:
            print("loading");
            return LoadingScreen();
          case ResponseState.COMPLETE:
            print("completed");

            RecipeDetail recipeDetail =
                viewModel.randomRecipeResponseState.data!;

            return FoundRecipeScreen(recipeDetail: recipeDetail);

          case ResponseState.ERROR:
            print("error");
            return Column();
          case ResponseState.INITIAL:
            print("initial");
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Random Recipe"),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      onPressed: _onRandomButtonPressed,
                      child: Text("Dice the roll!"))
                ],
              ),
            );
        }
      }),
    );
  }

  _onRandomButtonPressed() {
    final randomRecipeViewModel =
        Provider.of<RandomRecipeViewModel>(context, listen: false);
    randomRecipeViewModel.getRandomRecipe();
  }

}
