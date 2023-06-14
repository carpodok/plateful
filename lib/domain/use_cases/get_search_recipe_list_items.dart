import 'package:recipes_app/data/models/remote/ingredient_response.dart';
import 'package:recipes_app/data/models/remote/recipe_response.dart';
import 'package:recipes_app/domain/entities/ingredient.dart';

import '../../data/models/remote/search_recipe_response.dart';
import '../../data/repositories/recipe_repository.dart';
import '../entities/searched_recipe_list_item.dart';

class GetSearchedRecipeListItems {
  static Future<List<SearchedRecipeListItem>>? get(List<String> ingredients, int number) async {
    RecipeRepository _recipeRepository = RecipeRepository();

    List<SearchRecipeResponse>? searchedRecipes =
    await _recipeRepository.getRecipeByIngredients(ingredients, number);


    List<SearchedRecipeListItem> searchedRecipeListItems = [];
    List<Ingredient> usedIngredients = [];


    for (SearchRecipeResponse searchRecipeResponse in searchedRecipes!) {
      RecipeResponse? recipeDetailedInfo =
      await _recipeRepository.getRecipeById(searchRecipeResponse.id);

      for (IngredientResponse ingredient
      in searchRecipeResponse.usedIngredients) {
        usedIngredients.add(Ingredient(
            aisle: ingredient.aisle,
            amount: ingredient.amount,
            id: ingredient.id,
            image: ingredient.image,
            name: ingredient.name,
            original: ingredient.original,
            originalName: ingredient.originalName,
            unit: ingredient.unit,
            unitLong: ingredient.unitLong,
            unitShort: ingredient.unitShort));
      }

      searchedRecipeListItems.add(SearchedRecipeListItem(
          id: recipeDetailedInfo!.id,
          title: recipeDetailedInfo.title,
          image: recipeDetailedInfo.image,
          summary: recipeDetailedInfo.summary,
          usedIngredients: usedIngredients));
    }


    return searchedRecipeListItems;
  }
}
