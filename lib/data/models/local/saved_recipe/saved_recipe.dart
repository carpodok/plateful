import 'package:hive/hive.dart';
import 'ingredient/ingredient.dart';
part 'saved_recipe.g.dart';

@HiveType(typeId: 0)
class SavedRecipe {
  @HiveField(0)
  int id;

  @HiveField(1)
  String title;

  @HiveField(2)
  String image;

  @HiveField(3)
  String summary;

  @HiveField(4)
  List<IngredientModel> ingredients;

  SavedRecipe(
      {required this.id,
      required this.title,
      required this.image,
      required this.summary,
      required this.ingredients});
}
