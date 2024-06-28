import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/Ingredient/ingredient.dart';
import '../models/search_result.dart';
import '../providers/ingredient_provider.dart';
import '../utils/alert_helpers.dart';
import '../utils/image_helpers.dart';
import 'ingredient_details_screen.dart';
import 'master_screen.dart';

class ManageIngredientsScreen extends StatefulWidget {
  const ManageIngredientsScreen({super.key});

  @override
  State<ManageIngredientsScreen> createState() =>
      _ManageIngredientsScreenState();
}

class _ManageIngredientsScreenState extends State<ManageIngredientsScreen> {
  late IngredientProvider _ingredientProvider;
  final _searchController = TextEditingController();

  SearchResult<Ingredient>? ingredients;
  List<Ingredient> cachedIngredients = List.empty(growable: true);
  Timer? _searchTimer;

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _ingredientProvider = context.read<IngredientProvider>();
    initScreen();
  }

  Future initScreen() async {
    try {
      var result =
          await _ingredientProvider.get(filter: {"Page": 0, "PageSize": 10});

      cachedIngredients.addAll(result.result.where((ingredient) =>
          !cachedIngredients.any(
              (cachedIngredient) => cachedIngredient.name == ingredient.name)));

      setState(() {
        ingredients = result;
        isLoading = false;
      });
    } on Exception catch (e) {
      if (context.mounted) {
        AlertHelpers.showAlert(context, "Error", e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      title: "Manage ingredients",
      child: isLoading ? Container() : _buildScreen(),
    );
  }

  Widget _buildScreen() {
    if (ingredients?.result.isNotEmpty ?? false) {
      return Padding(
          padding: const EdgeInsets.only(left: 16.0, bottom: 16.0, right: 16.0),
          child: Column(children: [
            SingleChildScrollView(
                child: IntrinsicHeight(
                    child: Column(
              children: [
                _drawSearchField(),
                ...ingredients!.result
                    .map((ingredient) => _drawIngredientCard(ingredient))
              ],
            ))),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () => {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const IngredientDetailsScreen()))
                  },
                  child: const Card(
                    child: Padding(
                        padding: EdgeInsets.all(4),
                        child: Text("Add a new ingredient")),
                  ),
                )
              ],
            ),
          ]));
    } else {
      return const CircularProgressIndicator();
    }
  }

  Widget _drawIngredientCard(Ingredient ingredient) {
    return Card(
      child: Row(children: [
        const SizedBox(
          height: 80,
        ),
        Padding(
            padding: const EdgeInsets.only(left: 16, right: 16.0),
            child: ImageHelpers.getImage(ingredient.image)),
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              ingredient.name ?? "",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(getNutritionalInformation(ingredient))
          ],
        )),
        InkWell(
            onTap: () => {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          IngredientDetailsScreen(ingredient: ingredient)))
                },
            child: const Icon(Icons.create_outlined)),
        InkWell(
            onTap: () {
              _ingredientProvider.delete(ingredient.ingredientId!);
              setState(() {
                ingredients!.result.remove(ingredient);
                ingredients!.meta.count -= 1;
              });
            },
            child: const Icon(Icons.delete_outline)),
        const SizedBox(
          width: 16,
        )
      ]),
    );
  }

  Widget _drawSearchField() {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Colors.white),
        width: 200,
        child: TextField(
          onChanged: (value) => _handleChange(value),
          decoration: const InputDecoration(
              border: InputBorder.none,
              labelText: "Search",
              prefixIcon: Icon(Icons.search)),
          controller: _searchController,
        ));
  }

  void _handleChange(String searchText) {
    _searchTimer?.cancel();
    _searchTimer = Timer(const Duration(milliseconds: 250), () {
      if (searchText.length >= 3) {
        _performSearch(searchText);
      } else {
        setState(() {
          ingredients?.result = cachedIngredients;
          ingredients?.meta.count = cachedIngredients.length;
        });
      }
    });
  }

  void _performSearch(String searchText) async {
    try {
      var apiIngredients =
          await _ingredientProvider.get(filter: {'name': searchText});
      cachedIngredients.addAll(apiIngredients.result.where((ingredient) =>
          !cachedIngredients.any(
              (cachedIngredient) => cachedIngredient.name == ingredient.name)));

      setState(() {
        ingredients = apiIngredients;
      });
    } on Exception catch (e) {
      if (context.mounted) {
        AlertHelpers.showAlert(context, "Error", e.toString());
      }
    }
  }

  String getNutritionalInformation(Ingredient ingredient) =>
      "Fat (per 100g) ${ingredient.fat}, Protein (per 100g) ${ingredient.protein}, Calories (per 100g) ${ingredient.calories}, Carbs (per 100g) ${ingredient.carbs}";
}
