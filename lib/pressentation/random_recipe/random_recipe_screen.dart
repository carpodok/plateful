import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:recipes_app/data/models/local/saved_recipe/saved_recipe.dart';
import 'package:recipes_app/data/models/remote/random_recipe_response.dart';
import 'package:recipes_app/domain/entities/ingredient.dart';
import 'package:recipes_app/domain/entities/recipe_detail.dart';
import 'package:recipes_app/domain/use_cases/save_recipe.dart';
import 'package:recipes_app/pressentation/random_recipe/random_recipe_sceen_view_model.dart';
import '../../data/repositories/recipe_repository.dart';
import '../../utils/view_state.dart';
import '../widgets/loading_screen.dart';

class RandomRecipeScreen extends StatefulWidget {
  const RandomRecipeScreen({Key? key}) : super(key: key);

  @override
  State<RandomRecipeScreen> createState() => _RandomRecipeScreenState();
}

class _RandomRecipeScreenState extends State<RandomRecipeScreen> {
  late bool saved;
  late RecipeDetail currRecipe;

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
            currRecipe = recipeDetail;
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

    return Column(
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
            child: SingleChildScrollView(child: Text(recipeDetail.summary)),
          ),
        ),
        Expanded(
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: recipeDetail.ingredients.length,
                itemBuilder: (BuildContext context, int index) {
                  Ingredient ingredient = Ingredient(
                      aisle: "aisle",
                      amount: 0.0,
                      id: 0,
                      image: "image",
                      name: "name",
                      original: "original",
                      originalName: "originalName",
                      unit: "unit",
                      unitLong: "unitLong",
                      unitShort: "unitShort");
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
    );
  }

  _onGetRandomRecipeButtonPressed() {
    _getRandomRecipe();
  }

  _onSaveButtonPressed() {
    SavedRecipe savedRecipe = SavedRecipe(
        id: currRecipe.id,
        title: currRecipe.title,
        image: currRecipe.image,
        summary: currRecipe.summary,
        ingredients: []);

    SaveRecipe.saveRandomRecipe(savedRecipe);

    setState(() {
      if (saved) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("The recipe removed from the saved list")));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Saved the recipe successfully")));
      }
      saved = !saved;
    });
  }

  _getRandomRecipe() {
    final randomRecipeViewModel =
        Provider.of<RandomRecipeViewModel>(context, listen: false);
    randomRecipeViewModel.getRandomRecipe();
  }

  _ingredientsListItem(Ingredient ingredient) {}
}
