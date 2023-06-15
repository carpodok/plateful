import 'package:recipes_app/data/models/remote/recipe_response.dart';

import '../../data/models/remote/ingredient_response.dart';
import '../entities/ingredient.dart';

class GetRecipeIngrediients {
  static List<Ingredient> getIngredientsFromRecipeResponse(
      RecipeResponse recipeResponse) {
    List<Ingredient> ingredients = [];

    for (IngredientResponse ingredientResponse in recipeResponse.ingredients) {
      ingredients.add(
        Ingredient(
            name: ingredientResponse.name,
            amount: ingredientResponse.amount,
            image: ingredientResponse.image),
      );
    }

    return ingredients;
  }
}
