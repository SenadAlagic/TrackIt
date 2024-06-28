import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/Meal/meal.dart';
import '../providers/goal_provider.dart';
import '../providers/ingredient_provider.dart';
import '../providers/meal_provider.dart';
import '../providers/recommendation_provider.dart';
import '../providers/tag_provider.dart';
import '../providers/users_meal_provider.dart';
import '../utils/alert_helpers.dart';
import '../utils/image_helpers.dart';
import 'master_screen.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  late GoalProvider _goalProvider;
  late IngredientProvider _ingredientProvider;
  late MealProvider _mealProvider;
  late TagProvider _tagProvider;
  late RecommendationProvider _recommendationProvider;
  late UsersMealsProvider _usersMealsProvider;

  late List<Meal> mostPopularMeals;
  bool isLoading = true;

  int goals = 0;
  int ingredients = 0;
  int meals = 0;
  int tags = 0;

  @override
  void initState() {
    super.initState();
    _goalProvider = context.read<GoalProvider>();
    _ingredientProvider = context.read<IngredientProvider>();
    _mealProvider = context.read<MealProvider>();
    _tagProvider = context.read<TagProvider>();
    _mealProvider = context.read<MealProvider>();
    _recommendationProvider = context.read<RecommendationProvider>();
    _usersMealsProvider = context.read<UsersMealsProvider>();
    initScreen();
  }

  Future initScreen() async {
    try {
      var goalNumber = await _goalProvider.getForReport();
      var ingredientNumber = await _ingredientProvider.getForReport();
      var mealNumber = await _mealProvider.getForReport();
      var tagNumber = await _tagProvider.getForReport();

      var mostPopularMealsResults =
          await _usersMealsProvider.getMostPopularMeals();

      setState(() {
        goals = goalNumber;
        ingredients = ingredientNumber;
        meals = mealNumber;
        tags = tagNumber;
        mostPopularMeals = mostPopularMealsResults;
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
      title: "Reports",
      child: isLoading ? Container() : _buildScreen(),
    );
  }

  Widget _buildScreen() {
    return Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      _buildTitle(),
      _buildFirstRow(),
      const SizedBox(height: 20),
      _buildSecondRow(),
      _drawMostPopularMeals(),
      _drawDeleteRecommendationsButton(),
    ]));
  }

  Widget _drawMostPopularMeals() {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Column(
        children: [
          const Text(
            "Most popular meals",
            style: TextStyle(fontSize: 22),
          ),
          ...mostPopularMeals.map(
              (Meal meal) => SizedBox(width: 320, child: _drawMealCard(meal))),
        ],
      ),
    );
  }

  Padding _drawDeleteRecommendationsButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: ElevatedButton(
          style: const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Colors.white)),
          onPressed: () async =>
              await _recommendationProvider.deleteAllRecommendation(),
          child: const Text("Delete recommender results")),
    );
  }

  Padding _buildTitle() {
    return const Padding(
        padding: EdgeInsets.only(bottom: 32),
        child: Text(
          "View TrackIt reports",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
        ));
  }

  Row _buildFirstRow() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      _buildContainer("Total number of meals:", meals),
      const SizedBox(width: 20),
      _buildContainer("Total number of ingredients:", ingredients),
      const SizedBox(width: 20),
    ]);
  }

  Row _buildSecondRow() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      _buildContainer("Total number of tags:", tags),
      const SizedBox(width: 20),
      _buildContainer("Total number of goals:", goals),
      const SizedBox(width: 20),
    ]);
  }

  Widget _buildContainer(String hint, int number) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      height: 50,
      width: 300,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text("$hint $number", style: const TextStyle(fontSize: 18)),
      ),
    );
  }

  Widget _drawMealCard(Meal meal) {
    return Card(
      child: Row(children: [
        const SizedBox(
          height: 80,
        ),
        Padding(
            padding: const EdgeInsets.only(left: 16, right: 16.0),
            child: ImageHelpers.getImage(meal.image)),
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
      ]),
    );
  }
}
