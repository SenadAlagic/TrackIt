import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trackit_admin/providers/meal_provider.dart';
import 'package:trackit_admin/screens/meal_details_screen.dart';

import '../models/Meal/meal.dart';
import '../models/search_result.dart';
import 'master_screen.dart';

class ManageMealsScreen extends StatefulWidget {
  const ManageMealsScreen({super.key});

  @override
  State<ManageMealsScreen> createState() => _ManageMealsScreenState();
}

class _ManageMealsScreenState extends State<ManageMealsScreen> {
  late MealProvider _mealProvider;
  SearchResult<Meal>? meals;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _mealProvider = context.read<MealProvider>();
    initScreen();
  }

  Future initScreen() async {
    var result =
        await _mealProvider.get(filter: {'IsIngredientsIncluded': true});
    setState(() {
      meals = result;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      title: "Manage meals",
      child: isLoading ? Container() : _buildScreen(),
    );
  }

  Widget _buildScreen() {
    if (meals?.result.isNotEmpty ?? false) {
      return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(children: [
            SingleChildScrollView(
                child: IntrinsicHeight(
                    child: Column(
              children:
                  meals!.result.map((meal) => _drawMealCard(meal)).toList(),
            ))),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () => {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const MealDetailsScreen()))
                  },
                  child: const Card(
                    child: Padding(
                        padding: EdgeInsets.all(4),
                        child: Text("Add a new meal")),
                  ),
                )
              ],
            )
          ]));
    } else {
      return const CircularProgressIndicator();
    }
  }

  Widget _drawMealCard(Meal meal) {
    return Card(
      child: Row(children: [
        const SizedBox(
          height: 80,
        ),
        Padding(
            padding: const EdgeInsets.only(left: 16, right: 16.0),
            child: meal.image?.isNotEmpty ?? true
                ? Image.memory(
                    base64Decode(meal.image!),
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
              meal.name ?? "",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Container(
                constraints: const BoxConstraints(maxWidth: 300),
                padding: const EdgeInsets.only(right: 13.0),
                child: Text(
                  meal.description ?? "",
                  overflow: TextOverflow.ellipsis,
                )),
          ],
        )),
        InkWell(
            onTap: () => {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => MealDetailsScreen(meal: meal)))
                },
            child: const Icon(Icons.create_outlined)),
        InkWell(
            onTap: () {
              _mealProvider.delete(meal.mealId!);
              setState(() {
                meals!.result.remove(meal);
                meals!.count -= 1;
              });
            },
            child: const Icon(Icons.delete_outline)),
        const SizedBox(
          width: 16,
        )
      ]),
    );
  }
}
