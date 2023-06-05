import 'ingredient.dart';

class RecipeDetail {
  int id;
  String title;
  String image;
  String summary;
  List<Ingredient> ingredients;

  RecipeDetail(
      {required this.id,
      required this.title,
        required this.image,
      required this.summary,
      required this.ingredients});

}
