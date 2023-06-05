import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:recipes_app/domain/entities/searched_recipe_list_item.dart';
import 'package:recipes_app/pressentation/search_recipe/search_recipe_screen_view_model.dart';
import 'package:recipes_app/pressentation/widgets/loading_screen.dart';
import 'package:recipes_app/utils/view_state.dart';
import '../../data/datasources/recipe_remote_data_source.dart';
import '../../data/models/remote/recipe_response.dart';

class SearchRecipeScreen extends StatefulWidget {
  const SearchRecipeScreen({Key? key}) : super(key: key);

  @override
  State<SearchRecipeScreen> createState() => _SearchRecipeScreenState();
}

class _SearchRecipeScreenState extends State<SearchRecipeScreen> {
  RecipeRemoteDataSource apiService = RecipeRemoteDataSource();
  List<String> _ingredients = [];
  List<RecipeResponse> _recipes = [];
  int number = 1;

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
                    return Expanded(
                      child: ListView.builder(
                        itemCount: _recipes.length,
                        itemBuilder: (BuildContext context, int index) {
                          final listItem = SearchedRecipeListItem(
                              title: _recipes[index].title,
                              image: _recipes[index].image,
                              saved: true);
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: _listItem(listItem),
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
          prefixIcon: Icon(Icons.search),
          contentPadding: EdgeInsets.all(16.0),
        ),
      ),
    );
  }

  Widget _listItem(SearchedRecipeListItem searchedRecipeListItem) {
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: searchedRecipeListItem.saved
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
                      searchedRecipeListItem.saved
                          ? Icon(
                              Icons.star,
                              color: Colors.orangeAccent,
                            )
                          : Icon(
                              Icons.star_border,
                              color: Colors.black,
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
}
