import '../../data/repositories/recipe_repository.dart';

class UnSaveRecipe {
  static RecipeRepository _recipeRepository = RecipeRepository();

  static unSaveLastRecipe() {
    _recipeRepository.unSaveRecipe();
  }
}
