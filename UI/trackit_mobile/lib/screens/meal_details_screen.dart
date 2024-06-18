import 'package:flutter/material.dart';
import 'package:trackit_mobile/models/MealIngredient/meal_ingredient.dart';
import 'package:trackit_mobile/screens/master_screen.dart';
import 'package:trackit_mobile/utils/image_helpers.dart';

import '../models/Meal/meal.dart';

class MealDetailsScreen extends StatefulWidget {
  final Meal? meal;
  const MealDetailsScreen({super.key, this.meal});

  @override
  State<MealDetailsScreen> createState() => _MealDetailsScreenState();
}

class _MealDetailsScreenState extends State<MealDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      child: SingleChildScrollView(
        child: _drawScreen(),
      ),
    );
  }

  Widget _drawScreen() {
    Meal? meal = widget.meal;
    if (meal != null) {
      return Padding(
          padding: const EdgeInsets.all(16),
          child: Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Column(
                children: [
                  Padding(
                      padding: const EdgeInsets.only(top: 16, bottom: 12),
                      child: ImageHelpers.getImage(meal.image,
                          height: 120, width: 120)),
                  Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            meal.name!,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ))),
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("1 serving"),
                        Text("${meal.calories.toString()} kcal")
                      ],
                    ),
                  ),
                  const Divider(
                    thickness: 2,
                    color: Colors.black,
                  ),
                  _drawTable(),
                ],
              )));
    } else {
      return const Placeholder();
    }
  }

  Widget _drawTable() {
    Meal? meal = widget.meal;
    var scrollController = ScrollController();
    if (meal != null) {
      return Scrollbar(
          controller: scrollController,
          trackVisibility: true,
          thumbVisibility: true,
          child: SingleChildScrollView(
              controller: scrollController,
              scrollDirection: Axis.horizontal,
              child: DataTable(columns: [
                DataColumn(
                    label: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 100),
                        child: const Text("Ingredient"))),
                DataColumn(
                    label: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 50),
                        child: const Text("Fat"))),
                DataColumn(
                    label: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 50),
                        child: const Text("Carbs"))),
                DataColumn(
                    label: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 50),
                        child: const Text("Protein"))),
                DataColumn(
                    label: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 70),
                        child: const Text("Calories"))),
              ], rows: [
                ...meal.mealsIngredients!
                    .map((MealIngredient mealIngredient) => DataRow(cells: [
                          DataCell(Text(mealIngredient.ingredient!.name!)),
                          DataCell(Text(
                              "${mealIngredient.ingredient!.fat! * (mealIngredient.ingredientQuantity! / 100)} g")),
                          DataCell(Text(
                              "${mealIngredient.ingredient!.carbs! * (mealIngredient.ingredientQuantity! / 100)} g")),
                          DataCell(Text(
                              "${mealIngredient.ingredient!.protein! * (mealIngredient.ingredientQuantity! / 100)} g")),
                          DataCell(Text(
                              "${mealIngredient.ingredient!.calories! * (mealIngredient.ingredientQuantity! / 100)} kcal"))
                        ])),
                DataRow(cells: [
                  const DataCell(Text(
                    "Total",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
                  DataCell(Text(
                    "${meal.fat} g",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  )),
                  DataCell(Text(
                    "${meal.carbs} g",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  )),
                  DataCell(Text(
                    "${meal.protein} g",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  )),
                  DataCell(Text(
                    "${meal.calories} kcal",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ))
                ])
              ])));
    } else {
      return const Placeholder();
    }
  }
}
