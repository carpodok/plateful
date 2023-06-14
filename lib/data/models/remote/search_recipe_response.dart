import 'ingredient_response.dart';

class SearchRecipeResponse {
  int id;
  String title;
  String image;
  List<IngredientResponse> usedIngredients;

  SearchRecipeResponse({
    required this.id,
    required this.title,
    required this.image,
    required this.usedIngredients,
  });

  factory SearchRecipeResponse.fromjson(Map<String, dynamic> json) =>
      SearchRecipeResponse(
          id: json["id"],
          title: json["title"],
          image: json["image"],
          usedIngredients: List<IngredientResponse>.from(json["usedIngredients"]
              .map((x) => IngredientResponse.fromJson(x))));
}
