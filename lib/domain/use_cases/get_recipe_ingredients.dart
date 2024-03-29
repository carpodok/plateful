import 'package:recipes_app/data/models/remote/recipe_response.dart';

import '../../data/models/remote/ingredient_response.dart';
import '../entities/ingredient.dart';

class GetRecipeIngredients {
  static List<Ingredient> getIngredientsFromRecipeResponse(
      RecipeResponse recipeResponse) {
    List<Ingredient> ingredients = [];

    for (IngredientResponse ingredientResponse in recipeResponse.ingredients) {
      ingredients.add(
        Ingredient(
            name: ingredientResponse.name,
            amount: ingredientResponse.amount,
            image: "https://spoonacular.com/cdn/ingredients_100x100/${ingredientResponse.image}"),
      );
    }

    return ingredients;
  }
}
