import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:recipes_app/data/models/remote/random_recipe_response.dart';
import 'package:recipes_app/utils/constants.dart';

import '../models/remote/recipe_response.dart';

class RecipeRemoteDataSource {
  Future<List<RecipeResponse>?> fetchRecipesByIngredients(
      List<String> ingredients, int number) async {
    final encodedIngredients = ingredients.join(',');

    final uri = Uri.parse("$BASE_URL$SEARCH_RECIPES_BY_INGREDIENTS_END_POINT")
        .replace(queryParameters: {
      'ingredients': encodedIngredients,
      'number': number.toString(),
    });

    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'x-api-key': ' $API_KEY',
    };


    try {
      final response = await http.get(uri, headers: headers);

      print("response.body ${response.body}");
      print("status code ${response.statusCode}");

      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);

        List<RecipeResponse> recipes =
        body.map((dynamic item) => RecipeResponse.fromjson(item)).toList();

        return recipes;
      } else {
        // Error handling
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      throw "error in api_service class : $e";
    }

    return null;
  }

  Future<dynamic> getRecipeById(int id) async {
    final uri = "${BASE_URL}recipes/${id}/information";

    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'x-api-key': ' $API_KEY',
    };

    try {
      final response = await http.get(Uri.parse(uri), headers: headers);

      if (response.statusCode == 200) {

        final body = jsonDecode(response.body);
        return RecipeResponse.fromjson(body);
      } else {
        // Error handling
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      throw "error occured in api service : $e";
    }
  }

  Future<RandomRecipeResponse?> fetchRandomRecipe() async {

    final uri = Uri.parse("$BASE_URL$RANDOM_RECIPE_END_POINT");

  final Map<String, String> headers = {
    'Content-Type': 'application/json',
    'x-api-key': ' $API_KEY',
  };

    try {
      final response = await http.get(uri, headers: headers);

      print("response.body ${response.body}");
      print("status code ${response.statusCode}");

      if (response.statusCode == 200) {
        dynamic body = jsonDecode(response.body);

        return RandomRecipeResponse.fromJson(body);
      } else {
        // Error handling
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      throw "error in getRecipeById/api_service class : $e";
    }
    return null;


}}
