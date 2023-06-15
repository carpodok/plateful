import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:recipes_app/data/models/local/saved_recipe/saved_recipe.dart';
import 'package:recipes_app/data/models/remote/random_recipe_response.dart';
import 'package:recipes_app/domain/entities/ingredient.dart';
import 'package:recipes_app/domain/entities/recipe_detail.dart';
import 'package:recipes_app/domain/use_cases/save_recipe.dart';
import 'package:recipes_app/domain/use_cases/show_animated_toast_message.dart';
import 'package:recipes_app/domain/use_cases/unsave_recipe.dart';
import 'package:recipes_app/pressentation/random_recipe/random_recipe_sceen_view_model.dart';
import '../../data/repositories/recipe_repository.dart';
import '../../utils/constants.dart';
import '../../utils/view_state.dart';
import '../widgets/loading_screen.dart';

class RandomRecipeScreen extends StatefulWidget {
  const RandomRecipeScreen({Key? key}) : super(key: key);

  @override
  State<RandomRecipeScreen> createState() => _RandomRecipeScreenState();
}

class _RandomRecipeScreenState extends State<RandomRecipeScreen> {
  late bool saved;

  late RecipeDetail _currRecipe;

  @override
  void initState() {
    super.initState();

    saved = false;
    WidgetsBinding.instance
        .addPostFrameCallback((timeStamp) => _getRandomRecipe());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<RandomRecipeViewModel>(builder: (context, viewModel, _) {
        switch (viewModel.randomRecipeResponseState.state) {
          case ResponseState.LOADING:
            print("loading");
            return LoadingScreen();
          case ResponseState.COMPLETE:
            print("completed");

            RecipeDetail recipeDetail =
                viewModel.randomRecipeResponseState.data!;
            _currRecipe = recipeDetail;
            return _buildRandomRecipeBody(recipeDetail);

          case ResponseState.ERROR:
            print("error");
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text("Error")],
            ));
          case ResponseState.INITIAL:
            print("initial");
            return _buildInitialBody();
        }
      }),
    );
  }

  Widget _buildInitialBody() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Random Recipe"),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Color(0xffF4AA39)),
              ),
              onPressed: _onGetRandomRecipeButtonPressed,
              child: Text(
                "Dice the roll!",
                style: GoogleFonts.livvic(fontWeight: FontWeight.bold),
              ))
        ],
      ),
    );
  }

  Widget _buildRandomRecipeBody(RecipeDetail recipeDetail) {
    double screenWidth = MediaQuery.of(context).size.width;

    saved = false;
    final Box _savedRecipesBox = Hive.box(HIVE_DATABASE_KEY);

    for (var i = 0; i < _savedRecipesBox.length; i++) {
      SavedRecipe savedRecipe = _savedRecipesBox.getAt(i);
      if (_currRecipe.id == savedRecipe.id) saved = true;
    }

    return SingleChildScrollView(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              child: Container(
                width: screenWidth,
                child: Image.network(
                  recipeDetail.image,
                  // Replace with your own image URL
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              recipeDetail.title,
              style: GoogleFonts.livvic(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                children: [
                  Text(
                    "Recipe",
                    style: GoogleFonts.livvic(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: SizedBox(
                height: 200,
                child: SingleChildScrollView(child: Text(recipeDetail.summary)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Divider(
                color: CupertinoColors.inactiveGray,
                thickness: 1,
                height: 1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Text(
                    "Ingredients",
                    style: GoogleFonts.livvic(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: recipeDetail.ingredients.length,
                    itemBuilder: (BuildContext context, int index) {
                      Ingredient ingredient = Ingredient(
                        amount: recipeDetail.ingredients[index].amount,
                        image: recipeDetail.ingredients[index].image,
                        name: recipeDetail.ingredients[index].name,
                      );
                      return _ingredientsListItem(ingredient);
                    })),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _onGetRandomRecipeButtonPressed();
                  },
                  child: Text("Another Random Recipe"),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Color(0xffF4AA39)),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    _onSaveButtonPressed();
                  },
                  icon: saved
                      ? Icon(
                          Icons.star,
                          color: Color(0xffF4AA39),
                        )
                      : Icon(
                          Icons.star_border,
                          color: Color(0xffF4AA39),
                        ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  _onGetRandomRecipeButtonPressed() {
    _getRandomRecipe();
  }

  _onSaveButtonPressed() {
    setState(() {
      if (saved) {
        /* ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("The recipe removed from the saved list")));*/
        UnSaveRecipe.unSaveLastRecipe();
        ShowAnimatedToastMessage.showDeleteToastMessage(context);
      } else {
        /* ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Saved the recipe successfully")));*/
        SaveRecipe.saveRandomRecipe(_currRecipe);
        ShowAnimatedToastMessage.showSaveToastMessage(context);
      }
      saved = !saved;
    });
  }

  _getRandomRecipe() {
    final randomRecipeViewModel =
        Provider.of<RandomRecipeViewModel>(context, listen: false);
    randomRecipeViewModel.getRandomRecipe();
  }

  _ingredientsListItem(Ingredient ingredient) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(20),
              bottomLeft: Radius.circular(20),
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            child: Container(
              height: 50,
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
          Text(
            ingredient.name,
            style: GoogleFonts.livvic(),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            ingredient.amount.toString(),
            style: GoogleFonts.livvic(),
          ),
        ],
      ),
    );
  }
}
