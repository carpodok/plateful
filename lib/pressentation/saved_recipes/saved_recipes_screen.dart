import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:recipes_app/data/models/local/saved_recipe/saved_recipe.dart';
import 'package:recipes_app/domain/entities/recipe_detail.dart';
import 'package:recipes_app/domain/use_cases/delete_saved_recipe.dart';
import 'package:recipes_app/domain/use_cases/get_detail_recipe.dart';
import 'package:recipes_app/pressentation/recipe_detail/recipe_detail_screen.dart';
import 'package:recipes_app/utils/constants.dart';

import '../../domain/use_cases/show_animated_toast_message.dart';

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

              RecipeDetail recipeDetail =
                  GetRecipeDetail.getDetailRecipeFromSavedRecipe(
                      savedRecipeItem);

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => RecipeDetailScreen(
                            recipeDetail: recipeDetail,
                          ))),
                  child: ListTile(
                    title: Text(savedRecipeItem.title),
                    //subtitle: Text(savedRecipeItem.title),
                    trailing: InkWell(
                        onTap: () {
                          _onDeleteIconPressed(index);
                        },
                        child: Icon(
                          Icons.delete,
                          color: Colors.red,
                        )),
                    leading: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                      ),
                      child: Container(
                        height: 100,
                        child: Image.network(
                          savedRecipeItem.image,
                          // Replace with your own image URL
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        }
      },
    ));
  }

  void _onDeleteIconPressed(int index) {
    DeleteSavedRecipe.delete(index);

    ShowAnimatedToastMessage.showDeleteToastMessage(context);
  }
}
