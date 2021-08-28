import 'dart:convert';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:recetario/Model/Pokeapi.dart';
import 'package:recetario/Model/Recipe.dart';
import 'package:http/http.dart' as http;

class RecipeDetailPage extends StatefulWidget {
  final Recipe recipe;

  const RecipeDetailPage({Key? key, required this.recipe}) : super(key: key);

  @override
  _RecipeDetailPageState createState() => _RecipeDetailPageState();
}

class _RecipeDetailPageState extends State<RecipeDetailPage> {
  Future<List<PokeApi>>? _listadoPokeapi;

  Future<List<PokeApi>> _getPoke() async {
    final response = await http.get(
        Uri.parse("https://pokeapi.co/api/v2/pokemon?offset=300&limit=100"));

    List<PokeApi> pokes = [];

    if (response.statusCode == 200) {
      String cuerpo = utf8.decode(response.bodyBytes);
      final jsonData = jsonDecode(cuerpo);

      for (var item in jsonData["results"]) {
        pokes.add(PokeApi(item["name"]));
      }
      print(pokes);
      print(pokes.length);
      return pokes;
    } else {
      throw Exception("Fallo la conexion");
    }
  }

  @override
  void initState() {
    super.initState();
    _getPoke();
  }

  int _paginaActual = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gacha-MON"),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 300,
              width: double.infinity,
              child: Image(image: AssetImage(widget.recipe.imageRecipe)),
            ),
            SizedBox(
              height: 4,
            ),
            Text(widget.recipe.title, style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            _paginaActual = index;
          });
        },
        currentIndex: _paginaActual,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.adjust), label: "1 Tiro "),
          BottomNavigationBarItem(
              icon: Icon(Icons.animation), label: "10 Tiros")
        ],
      ),
    );
  }
}
