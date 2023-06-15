import 'package:recipes_app/data/models/local/saved_recipe/saved_recipe.dart';
import 'package:recipes_app/domain/entities/recipe_detail.dart';
import 'package:recipes_app/domain/entities/searched_recipe_list_item.dart';
import '../../data/models/local/saved_recipe/ingredient/ingredient.dart';
import '../entities/ingredient.dart';

class GetRecipeDetail {
  static RecipeDetail getDetailRecipeFromSearchedRecipe(
      SearchedRecipeListItem searchedRecipeListItem) {
    List<Ingredient> ingredients = [];

    ingredients.addAll(searchedRecipeListItem.usedIngredients);
    ingredients.addAll(searchedRecipeListItem.missedIngredients);

    return RecipeDetail(
        id: searchedRecipeListItem.id,
        title: searchedRecipeListItem.title,
        image: searchedRecipeListItem.image,
        summary: searchedRecipeListItem.summary,
        ingredients: ingredients);
  }

  static RecipeDetail getDetailRecipeFromSavedRecipe(SavedRecipe savedRecipe) {
    List<Ingredient> ingredients = [];

    for (IngredientModel ingredientModel in savedRecipe.ingredients) {
      ingredients.add(Ingredient(
        amount: ingredientModel.amount,
        image: ingredientModel.image,
        name: ingredientModel.title,
      ));
    }

    return RecipeDetail(
        id: savedRecipe.id,
        title: savedRecipe.title,
        image: savedRecipe.image,
        summary: savedRecipe.summary,
        ingredients: ingredients);
  }
}
