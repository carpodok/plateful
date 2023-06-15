import 'ingredient_response.dart';

class SearchRecipeResponse {
  int id;
  String title;
  String image;
  List<IngredientResponse> usedIngredients;
  List<IngredientResponse> missedIngredients;

  SearchRecipeResponse(
      {required this.id,
      required this.title,
      required this.image,
      required this.usedIngredients,
      required this.missedIngredients});

  factory SearchRecipeResponse.fromjson(Map<String, dynamic> json) =>
      SearchRecipeResponse(
        id: json["id"],
        title: json["title"],
        image: json["image"],
        usedIngredients: List<IngredientResponse>.from(
            json["usedIngredients"].map((x) => IngredientResponse.fromJson(x))),
        missedIngredients: List<IngredientResponse>.from(
            json["missedIngredients"]
                .map((x) => IngredientResponse.fromJson(x))),
      );
}
