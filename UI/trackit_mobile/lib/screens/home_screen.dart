import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/DailyIntake/daily_intake.dart';
import '../models/UserMeal/user_meal.dart';
import '../models/search_result.dart';
import '../providers/daily_intake_provider.dart';
import '../providers/user_meals_provider.dart';
import '../utils/alert_helpers.dart';
import '../utils/authorization.dart';
import '../utils/form_helpers.dart';
import '../utils/image_helpers.dart';
import '../utils/user_info.dart';
import 'master_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late UserMealsProvider _userMealsProvider;
  late DailyIntakeProvider _dailyIntakeProvider;
  SearchResult<UserMeal>? usersMeals;
  DailyIntake? dailyCalorieIntake;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _userMealsProvider = context.read<UserMealsProvider>();
    _dailyIntakeProvider = context.read<DailyIntakeProvider>();
    initScreen();
  }

  Future initScreen() async {
    try {
      var result = await _userMealsProvider.get(filter: {
        "userId": Authorization.generalUserId,
        "Date": DateTime.now().toIso8601String(),
        "isMealIncluded": true
      });
      var dailyIntakeResult = await _dailyIntakeProvider
          .get(filter: {"UserId": Authorization.generalUserId});

      setState(() {
        usersMeals = result;
        if (usersMeals?.result.isNotEmpty ?? false) {
          UserInfo.lastLoggedMealId = usersMeals!.result.last.mealId;
        }
        if (dailyIntakeResult.result.isNotEmpty) {
          dailyCalorieIntake = dailyIntakeResult.result[0];
        }
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
    return MasterScreen(child: SingleChildScrollView(child: _buildScreen()));
  }

  Widget _buildScreen() {
    return Container(
        decoration: const BoxDecoration(color: Color.fromRGBO(255, 235, 59, 1)),
        child: Center(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 12),
                child: Text("Welcome",
                    style:
                        TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
              ),
              _drawCalorieProgressIndicator(),
              _drawMealCards(usersMeals?.result)
            ],
          ),
        ));
  }

  Widget _drawCalorieProgressIndicator() {
    var dailyCaloriesNeeded =
        UserInfo.bmr! * UserInfo.user!.activityLevel!.multiplier!;
    double percentageCompleted = 0;
    if (dailyCalorieIntake?.calories != null) {
      percentageCompleted = dailyCalorieIntake!.calories! / dailyCaloriesNeeded;
    }
    return Padding(
        padding: const EdgeInsets.all(8),
        child: Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: Column(
              children: [
                const Padding(
                    padding: EdgeInsets.only(top: 4, bottom: 4),
                    child: Text("Calories")),
                Padding(
                    padding:
                        const EdgeInsets.only(left: 16, right: 16, bottom: 4),
                    child: LinearProgressIndicator(
                      backgroundColor: Colors.black,
                      color: Colors.yellow,
                      value: percentageCompleted,
                      minHeight: 10,
                      borderRadius: BorderRadius.circular(20),
                    )),
                Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                        padding: const EdgeInsets.only(right: 16, bottom: 8),
                        child: Text(
                            "${dailyCalorieIntake?.calories ?? 0}/$dailyCaloriesNeeded kcal")))
              ],
            )));
  }

  Widget _drawMealCards(List<UserMeal>? meals) {
    if (meals == null) {
      return FormHelpers.drawProgressIndicator();
    }
    if (meals.isEmpty) {
      return const Text(
        "No meals logged today",
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      );
    }
    return Column(children: [
      const Padding(
        padding: EdgeInsets.only(top: 32, bottom: 8),
        child: Text(
          "Today you ate",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
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
