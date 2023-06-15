import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recipes_app/domain/entities/recipe_detail.dart';

import '../../domain/entities/ingredient.dart';

class RecipeDetailScreen extends StatefulWidget {
  RecipeDetail recipeDetail;

  RecipeDetailScreen({
    super.key,
    required this.recipeDetail,
  });

  @override
  State<RecipeDetailScreen> createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends State<RecipeDetailScreen> {
  late RecipeDetail currRecipe;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currRecipe = widget.recipeDetail;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    print("ingredients size :${currRecipe.ingredients.length}");

    return Scaffold(
      body: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            child: Container(
              width: screenWidth,
              child: Image.network(
                currRecipe.image,
                // Replace with your own image URL
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            currRecipe.title,
            style: GoogleFonts.livvic(fontSize: 20),
          ),
          SizedBox(
            height: 10,
          ),
          Text("Recipe"),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: SizedBox(
              height: 250,
              child: SingleChildScrollView(child: Text(currRecipe.summary)),
            ),
          ),
          Expanded(
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: currRecipe.ingredients.length,
                  itemBuilder: (BuildContext context, int index) {
                    Ingredient ingredient = Ingredient(
                      amount: currRecipe.ingredients[index].amount,
                      image: currRecipe.ingredients[index].image,
                      name: currRecipe.ingredients[index].name,
                    );
                    return _ingredientsListItem(ingredient);
                  })),
        ],
      ),
    );
  }

  _ingredientsListItem(Ingredient ingredient) {

    return SizedBox(
      height: 50,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            child: Container(
              child: Image.network(
                ingredient.image,
                // Replace with your own image URL
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(ingredient.name),
          SizedBox(
            height: 5,
          ),
          Text(ingredient.amount.toString()),
        ],
      ),
    );
  }
}
