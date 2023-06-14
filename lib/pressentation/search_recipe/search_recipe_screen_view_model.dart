import 'package:flutter/cupertino.dart';
import 'package:recipes_app/data/repositories/recipe_repository.dart';
import 'package:recipes_app/domain/entities/searched_recipe_list_item.dart';
import 'package:recipes_app/domain/use_cases/get_search_recipe_list_items.dart';
import '../../data/datasources/recipe_remote_data_source.dart';
import '../../data/models/remote/recipe_response.dart';
import '../../data/models/remote/search_recipe_response.dart';
import '../../utils/view_state.dart';

class SearchRecipeScreenViewModel extends ChangeNotifier {
  RecipeRemoteDataSource _apiService = RecipeRemoteDataSource();

  RecipeRepository _recipeRepository = RecipeRepository();

  ViewState<List<SearchedRecipeListItem>> recipesResponseState =
      ViewState(state: ResponseState.INITIAL);

  _setRecipesResponseState(
      ViewState<List<SearchedRecipeListItem>> recipesResponseState) {
    this.recipesResponseState = recipesResponseState;
    notifyListeners();
  }

  Future<void> getRecipesByIngredients(
      List<String> ingredients, int number) async {
    _setRecipesResponseState(ViewState.loading());

    //final response = await _recipeRepository.getRecipeByIngredients(ingredients, number);
    final response = await GetSearchedRecipeListItems.get(ingredients, number);

    if (response != null) {
      _setRecipesResponseState(ViewState.complete(response));
    } else {
      _setRecipesResponseState(ViewState.error("Error in fetching recipes"));
    }
  }
}
