import 'package:recipes_app/data/models/remote/recipe_response.dart';

class RandomRecipeResponse {
  List<RecipeResponse> recipes;

  RandomRecipeResponse({
    required this.recipes,
  });

  factory RandomRecipeResponse.fromJson(Map<String, dynamic> json) => RandomRecipeResponse(
    recipes: List<RecipeResponse>.from(json["recipes"].map((x) => RecipeResponse.fromjson(x))),
  );

}