import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:recipes_app/data/models/local/saved_recipe/saved_recipe.dart';
import 'package:recipes_app/pressentation/recipe_detail/recipe_detail_screen.dart';
import 'package:recipes_app/utils/constants.dart';

class SavedRecipesScreen extends StatefulWidget {
  const SavedRecipesScreen({Key? key}) : super(key: key);

  @override
  State<SavedRecipesScreen> createState() => _SavedRecipesScreenState();
}

class _SavedRecipesScreenState extends State<SavedRecipesScreen> {
  late final Box _savedRecipesBox;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _savedRecipesBox = Hive.box(HIVE_DATABASE_KEY);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ValueListenableBuilder(
      valueListenable: _savedRecipesBox.listenable(),
      builder: (context, Box box, _) {
        if (box.isEmpty) {
          return Center(
            child: Text('There is no saved recipe yet'),
          );
        } else {
          return ListView.builder(
            itemCount: box.length,
            itemBuilder: (contex, index) {
              var currBox = box;
              SavedRecipe recipeData = currBox.getAt(index);

              final SavedRecipe savedRecipeItem = SavedRecipe(
                  id: recipeData.id,
                  title: recipeData.title,
                  image: recipeData.image,
                  summary: recipeData.summary,
                  ingredients: recipeData.ingredients);

              return InkWell(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => RecipeDetailScreen())),
                child: ListTile(
                  title: Text(savedRecipeItem.title),
                  subtitle: Text(savedRecipeItem.title),
                  trailing: Image.network(savedRecipeItem.image),
                ),
              );
            },
          );
        }
      },
    ));
  }
}
