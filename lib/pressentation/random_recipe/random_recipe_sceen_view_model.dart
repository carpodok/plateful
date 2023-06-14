import 'package:flutter/cupertino.dart';
import 'package:recipes_app/domain/entities/ingredient.dart';
import 'package:recipes_app/domain/entities/recipe_detail.dart';

import '../../data/datasources/recipe_remote_data_source.dart';
import '../../data/models/remote/random_recipe_response.dart';
import '../../utils/view_state.dart';

class RandomRecipeViewModel extends ChangeNotifier {
  RecipeRemoteDataSource _apiService = RecipeRemoteDataSource();

  ViewState<RecipeDetail> randomRecipeResponseState =
      ViewState(state: ResponseState.INITIAL);

  _setRandomRecipeResponseState(
      ViewState<RecipeDetail> randomRecipeResponseState) {
    this.randomRecipeResponseState = randomRecipeResponseState;
    notifyListeners();
  }

  getRandomRecipe() async {
    _setRandomRecipeResponseState(ViewState.loading());

    final response = await _apiService.fetchRandomRecipe();

    if (response != null) {
      final recipeResponse = response.recipes[0];

      final RecipeDetail recipeDetail = RecipeDetail(
          id: recipeResponse.id,
          title: recipeResponse.title,
          image: recipeResponse.image,
          summary: recipeResponse.summary,
          ingredients: []);

      _setRandomRecipeResponseState(ViewState.complete(recipeDetail));
    } else {
      _setRandomRecipeResponseState(
          ViewState.error("Error occurred on fetching random recipe"));
    }
  }
}
