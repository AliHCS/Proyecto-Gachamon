import 'package:flutter/material.dart';
import 'package:recetario/Model/Recipe.dart';
import 'package:recetario/Pages/RecipeDetailPage.dart';

class RecipesHomePage extends StatefulWidget {
  RecipesHomePage({Key? key}) : super(key: key);

  @override
  _RecipesHomePageState createState() => _RecipesHomePageState();
}

class _RecipesHomePageState extends State<RecipesHomePage> {
  static List<Recipe> muestras = [
    Recipe("BANER LEGENDARIO", "assets/images/baner1.jpeg"),
    Recipe("BANER EPICO ", "assets/images/baner2.jpeg"),
    Recipe("BANER COMUN", "assets/images/baner3.jpg")
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Gacha-MON"),
        ),
        body: SafeArea(
          child: ListView.builder(
            itemCount: muestras.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return RecipeDetailPage(
                          recipe: muestras[index],
                        );
                      },
                    ),
                  );
                },
                child: widgetRecipeCard(muestras[index]),
              );
            },
          ),
        ));
  }
}

Widget widgetRecipeCard(Recipe recipe) {
  return Card(
    elevation: 5.0,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          Image(image: AssetImage(recipe.imageRecipe)),
          SizedBox(
            height: 15.0,
          ),
          Text(recipe.title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
        ],
      ),
    ),
  );
}
