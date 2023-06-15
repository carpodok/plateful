import '../../data/repositories/recipe_repository.dart';

class DeleteSavedRecipe{

  static RecipeRepository _recipeRepository = RecipeRepository();


  static delete(int index){

    _recipeRepository.deleteSavedRecipe(index);

  }
}