import 'package:recipes_app/data/models/remote/random_recipe_response.dart';

import '../datasources/recipe_remote_data_source.dart';

class RecipeDetailRepository {
  RecipeRemoteDataSource _apiService = RecipeRemoteDataSource();

  Future<RandomRecipeResponse?> getRandomRecipe() =>
      _apiService.fetchRandomRecipe();

  getSimilarRecipes(int id) {}

  getRecipe(int id) {}

  getIngredients(int id) {}
}
