import 'package:flutter/material.dart';
import 'package:recipes_app/data/models/local/saved_recipe/ingredient/ingredient.dart';
import 'package:recipes_app/data/models/local/saved_recipe/saved_recipe.dart';
import 'package:recipes_app/data/repositories/recipe_repository.dart';
import 'package:recipes_app/domain/entities/searched_recipe_list_item.dart';

class SaveRecipe {

  static RecipeRepository _recipeRepository = RecipeRepository();

  static save(SearchedRecipeListItem searchedRecipeListItem) {

    List<Ingredient> ingredients = [];

    _recipeRepository.saveRecipe(SavedRecipe(
        id: searchedRecipeListItem.id,
        title: searchedRecipeListItem.title,
        image: searchedRecipeListItem.image,
        summary: searchedRecipeListItem.summary,
        ingredients: ingredients));
  }

  static saveRandomRecipe(SavedRecipe savedRecipe){
    _recipeRepository.saveRecipe(savedRecipe);
  }

  static save2(int recipeId) {
    RecipeRepository _recipeRepository = RecipeRepository();
    _recipeRepository.saveRecipe2(recipeId);
  }
}
