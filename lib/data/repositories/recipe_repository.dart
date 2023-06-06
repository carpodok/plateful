import 'package:hive/hive.dart';
import 'package:recipes_app/data/models/remote/random_recipe_response.dart';
import 'package:recipes_app/utils/constants.dart';

import '../datasources/recipe_remote_data_source.dart';
import '../models/local/saved_recipe/saved_recipe.dart';

class RecipeRepository {
  RecipeRemoteDataSource _apiService = RecipeRemoteDataSource();
  Box _box = Hive.box(HIVE_DATABASE_KEY);

  Future<RandomRecipeResponse?> getRandomRecipe() =>
      _apiService.fetchRandomRecipe();


  // Database Actions
  saveRecipe(SavedRecipe savedRecipe) {
    _box.add(savedRecipe);
  }

  deleteSavedRecipe(int index) {
    _box.deleteAt(index);
  }

  deleteAllSavedRecipe() {
    _box.clear();
  }



  // API Calls
  getSimilarRecipes(int id) {}

  getRecipe(int id) {}

  getIngredients(int id) {}
}
