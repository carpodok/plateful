import 'ingredient_response.dart';

class RecipeResponse {
  int id;
  String title;
  String image;
  String summary;
  List<IngredientResponse> ingredients;

  RecipeResponse(
      {required this.id,
      required this.title,
      required this.image,
      required this.summary,
      required this.ingredients});

  factory RecipeResponse.fromjson(Map<String, dynamic> json) => RecipeResponse(
        id: json["id"],
        title: json["title"],
        image: json["image"],
        summary: json["summary"],
        ingredients: List<IngredientResponse>.from(json["extendedIngredients"]
            .map((x) => IngredientResponse.fromJson(x))),
      );
}
