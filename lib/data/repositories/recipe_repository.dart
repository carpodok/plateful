import 'package:hive/hive.dart';
import 'package:recipes_app/data/models/remote/random_recipe_response.dart';
import 'package:recipes_app/data/models/remote/recipe_response.dart';
import 'package:recipes_app/utils/constants.dart';

import '../datasources/recipe_remote_data_source.dart';
import '../models/local/saved_recipe/saved_recipe.dart';
import '../models/remote/search_recipe_response.dart';

class RecipeRepository {
  RecipeRemoteDataSource _apiService = RecipeRemoteDataSource();
  Box _box = Hive.box(HIVE_DATABASE_KEY);

  // Database Actions
  saveRecipe(SavedRecipe savedRecipe) {
    _box.add(savedRecipe);
  }

  unSaveRecipe(){
    final lastIndex = _box.length-1;
    _box.deleteAt(lastIndex);
  }

  deleteSavedRecipe(int index) {
    _box.deleteAt(index);
  }

  deleteAllSavedRecipe() {
    _box.clear();
  }

  // API Calls
  Future<RandomRecipeResponse?> getRandomRecipe() =>
      _apiService.fetchRandomRecipe();

  Future<RecipeResponse?> getRecipeById(int id) {
    return _apiService.fetchRecipeById(id);
  }

  Future<List<SearchRecipeResponse>?> getRecipeByIngredients(
      List<String> ingredients, int number) async {
    return _apiService.fetchRecipesByIngredients(ingredients, number);
  }
}
