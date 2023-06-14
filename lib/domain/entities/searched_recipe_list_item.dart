import 'ingredient.dart';

class SearchedRecipeListItem {
  int id;
  String title;
  String image;
  String summary;
  List<Ingredient> usedIngredients;


  SearchedRecipeListItem(
      {required this.id,
      required this.title,
      required this.image,
      required this.summary,
      required this.usedIngredients});
}
