import 'package:hive_flutter/adapters.dart';

part 'ingredient.g.dart';

@HiveType(typeId: 1)
class IngredientModel {

  @HiveField(0)
  String title;

  @HiveField(1)
  String image;

  @HiveField(2)
  double amount;

  IngredientModel({
    required this.title,
    required this.image,
    required this.amount,
  });
}