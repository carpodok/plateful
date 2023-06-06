import 'package:flutter/material.dart';
import 'package:recipes_app/data/models/local/saved_recipe/saved_recipe.dart';
import 'package:recipes_app/data/repositories/recipe_repository.dart';

class SaveRecipe{

  RecipeRepository _recipeRepository = RecipeRepository();

  save(SavedRecipe savedRecipe){

    _recipeRepository.saveRecipe(savedRecipe);

  }
}