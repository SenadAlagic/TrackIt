import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trackit_admin/models/search_result.dart';
import 'package:trackit_admin/providers/ingredient_provider.dart';
import 'package:trackit_admin/screens/ingredient_details_screen.dart';

import '../models/Ingredient/ingredient.dart';
import '../widgets/PaginationWidget/pagination_widget.dart';
import 'master_screen.dart';

class ManageIngredientsScreen extends StatefulWidget {
  const ManageIngredientsScreen({super.key});

  @override
  State<ManageIngredientsScreen> createState() =>
      _ManageIngredientsScreenState();
}

class _ManageIngredientsScreenState extends State<ManageIngredientsScreen> {
  late IngredientProvider _ingredientProvider;
  SearchResult<Ingredient>? ingredients;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _ingredientProvider = context.read<IngredientProvider>();
    initScreen();
  }

  Future initScreen() async {
    var result =
        await _ingredientProvider.get(filter: {"Page": 0, "PageSize": 5});

    setState(() {
      ingredients = result;
      isLoading = false;
    });
  }

  void onResultFetched(SearchResult<dynamic> result) {
    setState(() {
      ingredients = result as SearchResult<Ingredient>;
      isLoading = false;
    });
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
          padding: const EdgeInsets.all(16.0),
          child: Column(children: [
            SingleChildScrollView(
                child: IntrinsicHeight(
                    child: Column(
              children: ingredients!.result
                  .map((ingredient) => _drawIngredientCard(ingredient))
                  .toList(),
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
            PaginationWidget(
                ingredients!, _ingredientProvider, onResultFetched, 5)
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
            child: ingredient.image?.isNotEmpty ?? true
                ? Image.memory(
                    base64Decode(ingredient.image!),
                    height: 40,
                    width: 40,
                  )
                : Image.asset("assets/images/NoImageFound.jpg",
                    height: 40, width: 40)),
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

  String getNutritionalInformation(Ingredient ingredient) =>
      "Fat (per 100g) ${ingredient.fat}, Protein (per 100g) ${ingredient.protein}, Calories (per 100g) ${ingredient.calories}, Carbs (per 100g) ${ingredient.carbs}";
}
