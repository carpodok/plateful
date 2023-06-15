import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:recipes_app/data/models/local/saved_recipe/saved_recipe.dart';
import 'package:recipes_app/data/models/remote/ingredient_response.dart';
import 'package:recipes_app/domain/entities/ingredient.dart';
import 'package:recipes_app/domain/entities/recipe_detail.dart';
import 'package:recipes_app/domain/entities/searched_recipe_list_item.dart';
import 'package:recipes_app/domain/use_cases/get_detail_recipe.dart';
import 'package:recipes_app/pressentation/search_recipe/search_recipe_screen_view_model.dart';
import 'package:recipes_app/pressentation/widgets/loading_screen.dart';
import 'package:recipes_app/utils/view_state.dart';
import '../../data/datasources/recipe_remote_data_source.dart';
import '../../data/models/remote/recipe_response.dart';
import '../../data/models/remote/search_recipe_response.dart';
import '../../domain/use_cases/save_recipe.dart';
import '../../utils/constants.dart';
import '../recipe_detail/recipe_detail_screen.dart';

class SearchRecipeScreen extends StatefulWidget {
  const SearchRecipeScreen({Key? key}) : super(key: key);

  @override
  State<SearchRecipeScreen> createState() => _SearchRecipeScreenState();
}

class _SearchRecipeScreenState extends State<SearchRecipeScreen> {
  // RecipeRemoteDataSource apiService = RecipeRemoteDataSource();
  List<String> _ingredients = [];
  List<SearchedRecipeListItem> _recipes = [];
  int number = 1;
  final Box _savedRecipesBox = Hive.box(HIVE_DATABASE_KEY);

  void _updateWords(String text) {
    setState(() {
      _ingredients = text.split(' ');
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Image.asset(
                'assets/images/logo.png',
                width: 100,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "What's you got ?",
                style: GoogleFonts.livvic(fontSize: 20),
              ),
              SizedBox(
                height: 20,
              ),
              _searchBar(),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 20,
              ),
              Consumer<SearchRecipeScreenViewModel>(
                  builder: (context, viewModel, _) {
                switch (viewModel.recipesResponseState.state) {
                  case ResponseState.LOADING:
                    print("loading");
                    return LoadingScreen();
                  case ResponseState.COMPLETE:
                    print("completed");
                    _recipes = viewModel.recipesResponseState.data!;

                    print("${_recipes.length}");
                    return Expanded(
                      child: ListView.builder(
                        itemCount: _recipes.length,
                        itemBuilder: (BuildContext context, int index) {
                          bool saved = false;

                          for (var i = 0; i < _savedRecipesBox.length; i++) {
                            SavedRecipe savedRecipe = _savedRecipesBox.getAt(i);
                            saved = _recipes[index].id == savedRecipe.id;
                          }

                          final searchedRecipeListItem = SearchedRecipeListItem(
                              id: _recipes[index].id,
                              title: _recipes[index].title,
                              image: _recipes[index].image,
                              summary: _recipes[index].summary,
                              usedIngredients: _recipes[index].usedIngredients,
                              missedIngredients:
                                  _recipes[index].missedIngredients);

                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => RecipeDetailScreen(
                                            recipeDetail: GetRecipeDetail
                                                .getDetailRecipeFromSearchedRecipe(
                                                    searchedRecipeListItem),
                                          )));
                                },
                                child: _listItem(searchedRecipeListItem, saved)),
                          );
                        },
                      ),
                    );

                  case ResponseState.ERROR:
                    print("error");
                    return Column();
                  case ResponseState.INITIAL:
                    print("initial");
                    return Column();
                }
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _searchBar() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Colors.grey[200],
      ),
      child: TextField(
        onChanged: (text) {
          _ingredients.clear();
          _ingredients = text.split(' ');

          if (text != "" && _ingredients.isNotEmpty) {
            final homeScreenViewModel =
                Provider.of<SearchRecipeScreenViewModel>(context,
                    listen: false);
            homeScreenViewModel.getRecipesByIngredients(_ingredients, number);
          }
        },
        decoration: InputDecoration(
          suffixStyle: GoogleFonts.livvic(),
          hintText: 'Apple,flour...',
          border: InputBorder.none,
          prefixIcon: Icon(
            Icons.search,
            color: Color(0xffF4AA39),
          ),
          contentPadding: EdgeInsets.all(16.0),
        ),
      ),
    );
  }

  Widget _listItem(SearchedRecipeListItem searchedRecipeListItem, bool saved) {
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: saved
            ? BorderSide(width: 2, color: Colors.orangeAccent)
            : BorderSide.none,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              flex: 5,
              child: Column(
                children: [
                  Column(
                    children: [
                      Text(
                        searchedRecipeListItem.title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Body Text',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      saved
                          ? InkWell(
                              onTap: () {
                                print("pressed saved icon");
                              },
                              child: Icon(
                                Icons.star,
                                color: Colors.orangeAccent,
                              ),
                            )
                          : InkWell(
                              onTap: () {
                                print("pressed unsaved icon");
                                setState(() {
                                  _saveRecipe(searchedRecipeListItem);
                                });
                              },
                              child: Icon(
                                Icons.star_border,
                                color: Colors.black,
                              ),
                            )
                    ],
                  )
                ],
              ),
            ),
            Spacer(),
            Expanded(
              flex: 3,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
                child: Container(
                  height: 100,
                  child: Image.network(
                    searchedRecipeListItem.image,
                    // Replace with your own image URL
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _saveRecipe(SearchedRecipeListItem searchedRecipeListItem) {
    SaveRecipe.saveSearchedRecipeListItem(searchedRecipeListItem);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Saved successfully!'),
      ),
    );
  }
}
