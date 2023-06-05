import 'package:flutter/cupertino.dart';
import '../../data/datasources/recipe_remote_data_source.dart';
import '../../data/models/remote/recipe_response.dart';
import '../../utils/view_state.dart';

class SearchRecipeScreenViewModel extends ChangeNotifier {
  RecipeRemoteDataSource _apiService = RecipeRemoteDataSource();

  ViewState<List<RecipeResponse>> recipesResponseState =
  ViewState(state: ResponseState.INITIAL);

  _setRecipesResponseState(
      ViewState<List<RecipeResponse>> recipesResponseState) {
    this.recipesResponseState = recipesResponseState;
    notifyListeners();
  }

  Future<void> getRecipesByIngredients(List<String> ingredients, int number) async {

    _setRecipesResponseState(ViewState.loading());

    final response = await _apiService.fetchRecipesByIngredients(ingredients, number);

    if(response != null){

      _setRecipesResponseState(ViewState.complete(response));
    }else{
      _setRecipesResponseState(ViewState.error("Error in fetching recipes"));
    }
  }
}
