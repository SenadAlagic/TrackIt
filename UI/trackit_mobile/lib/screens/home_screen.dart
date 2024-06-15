import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trackit_mobile/models/UserMeal/user_meal.dart';
import 'package:trackit_mobile/utils/authorization.dart';
import 'package:trackit_mobile/utils/form_helpers.dart';
import 'package:trackit_mobile/utils/image_helpers.dart';

import '../models/search_result.dart';
import '../providers/user_meals_provider.dart';
import 'master_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late UserMealsProvider _userMealsProvider;
  SearchResult<UserMeal>? usersMeals;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _userMealsProvider = context.read<UserMealsProvider>();
    initScreen();
  }

  Future initScreen() async {
    var result = await _userMealsProvider.get(filter: {
      "userId": Authorization.generalUserId,
      "Date": DateTime.now().toIso8601String(),
      "isMealIncluded": true
    });

    setState(() {
      usersMeals = result;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
        child: SingleChildScrollView(
      child: _drawScreen(),
    ));
  }

  Widget _drawScreen() {
    if (usersMeals?.result.isNotEmpty ?? false) {
      return Container(
          decoration:
              const BoxDecoration(color: Color.fromRGBO(255, 235, 59, 1)),
          child: Center(
            child: Column(
              children: [
                const Text(
                  "Welcome",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                _drawMealCards(usersMeals!.result)
              ],
            ),
          ));
    } else {
      return FormHelpers.drawProgressIndicator();
    }
  }

  Widget _drawMealCards(List<UserMeal> meals) {
    if (meals.isEmpty) {
      return const Text(
        "No meals logged today",
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      );
    }
    return Column(children: [
      const Text(
        "Today you ate",
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      ...meals
          .map((UserMeal userMeal) => Card(
                child: Row(children: [
                  Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16.0),
                      child: ImageHelpers.getImage(userMeal.meal!.image,
                          height: 100, width: 80)),
                  Expanded(
                      child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                userMeal.meal!.name ?? "",
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              Text("${userMeal.servings} serving(s)"),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                            "protein ${userMeal.meal!.protein}g"),
                                        Text("fat ${userMeal.meal!.fat}g"),
                                        Text("carbs ${userMeal.meal!.carbs}g"),
                                      ])
                                ],
                              ),
                              Text("${userMeal.meal!.calories} kcal"),
                            ],
                          ))),
                ]),
              ))
          .toList()
    ]);
  }
}
