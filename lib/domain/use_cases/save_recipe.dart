import 'package:flutter/material.dart';
import 'package:recipes_app/data/models/local/saved_recipe/ingredient/ingredient.dart';
import 'package:recipes_app/data/models/local/saved_recipe/saved_recipe.dart';
import 'package:recipes_app/data/repositories/recipe_repository.dart';
import 'package:recipes_app/domain/entities/ingredient.dart';
import 'package:recipes_app/domain/entities/recipe_detail.dart';
import 'package:recipes_app/domain/entities/searched_recipe_list_item.dart';

class SaveRecipe {
  static RecipeRepository _recipeRepository = RecipeRepository();

  static saveSearchedRecipeListItem(
      SearchedRecipeListItem searchedRecipeListItem) {
    List<IngredientModel> ingredients = [];

    for (Ingredient ingredient in searchedRecipeListItem.missedIngredients) {
      ingredients.add(IngredientModel(
          title: ingredient.name,
          image: ingredient.image,
          amount: ingredient.amount));
    }

    for (Ingredient ingredient in searchedRecipeListItem.usedIngredients) {
      ingredients.add(IngredientModel(
          title: ingredient.name,
          image: ingredient.image,
          amount: ingredient.amount));
    }

    _recipeRepository.saveRecipe(SavedRecipe(
        id: searchedRecipeListItem.id,
        title: searchedRecipeListItem.title,
        image: searchedRecipeListItem.image,
        summary: searchedRecipeListItem.summary,
        ingredients: ingredients));
  }

  static saveRandomRecipe(RecipeDetail recipeDetail) {
    List<IngredientModel> ingredients = [];

    for (Ingredient ingredient in recipeDetail.ingredients) {
      ingredients.add(IngredientModel(
          title: ingredient.name,
          image: ingredient.image,
          amount: ingredient.amount));
    }

    SavedRecipe savedRecipe = SavedRecipe(
        id: recipeDetail.id,
        title: recipeDetail.title,
        image: recipeDetail.image,
        summary: recipeDetail.summary,
        ingredients: ingredients);

    _recipeRepository.saveRecipe(savedRecipe);
  }
}
