import 'package:hive_flutter/adapters.dart';

part 'ingredient.g.dart';

@HiveType(typeId: 0)
class Ingredient {

  @HiveField(0)
  String title;

  @HiveField(1)
  String image;

  Ingredient({
    required this.title,
    required this.image,
  });
}