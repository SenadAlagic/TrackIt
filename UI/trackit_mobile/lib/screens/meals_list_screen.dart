import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/Meal/meal.dart';
import '../models/search_result.dart';
import '../providers/meal_provider.dart';
import '../utils/alert_helpers.dart';
import '../utils/form_helpers.dart';
import '../utils/image_helpers.dart';
import '../widgets/pagination_widget.dart';
import 'master_screen.dart';
import 'meal_details_screen.dart';

class MealsListScreen extends StatefulWidget {
  final List<Meal>? meals;
  const MealsListScreen({super.key, this.meals});

  @override
  State<MealsListScreen> createState() => _MealsListScreenState();
}

class _MealsListScreenState extends State<MealsListScreen> {
  late MealProvider _mealProvider;
  SearchResult<Meal>? meals;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _mealProvider = context.read<MealProvider>();
    if (widget.meals == null) {
      initScreen();
    }
  }

  Future initScreen() async {
    try {
      var result = await _mealProvider.get(
          filter: {'IsIngredientsIncluded': true, "Page": 0, "PageSize": 5});
      setState(() {
        meals = result;
        isLoading = false;
      });
    } on Exception catch (e) {
      if (context.mounted) {
        AlertHelpers.showAlert(context, "Error", e.toString());
      }
    }
  }

  void onResultFetched(SearchResult<dynamic> result) {
    setState(() {
      meals = result as SearchResult<Meal>;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      title: "Meals list",
      child: SingleChildScrollView(child: _buildScreen()),
    );
  }

  Widget _buildScreen() {
    if (meals?.result.isNotEmpty ?? false || widget.meals != null) {
      return Padding(
          padding: const EdgeInsets.all(16.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            SingleChildScrollView(
                child: IntrinsicHeight(
                    child: Column(
              children: widget.meals != null
                  ? widget.meals!.map((meal) => _drawMealCard(meal)).toList()
                  : meals!.result.map((meal) => _drawMealCard(meal)).toList(),
            ))),
            widget.meals == null
                ? PaginationWidget(
                    meals!,
                    _mealProvider,
                    onResultFetched,
                    5,
                    filter: const {"IsIngredientsIncluded": true},
                  )
                : const SizedBox(),
          ]));
    } else {
      return FormHelpers.drawProgressIndicator();
    }
  }

  Widget _drawMealCard(Meal meal) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: ElevatedButton(
          style: const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Colors.white)),
          onPressed: () => Navigator.of(context).push(MaterialPageRoute(
              builder: ((context) => MealDetailsScreen(meal: meal)))),
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
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
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
            const SizedBox(
              width: 16,
            )
          ]),
        ));
  }
}
