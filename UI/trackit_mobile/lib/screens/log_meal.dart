import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

import '../models/Meal/meal.dart';
import '../models/search_result.dart';
import '../providers/meal_provider.dart';
import '../providers/user_meals_provider.dart';
import '../utils/alert_helpers.dart';
import '../utils/form_helpers.dart';
import '../utils/image_helpers.dart';
import '../utils/user_info.dart';
import 'home_screen.dart';
import 'master_screen.dart';

class LogMealScreen extends StatefulWidget {
  const LogMealScreen({super.key});

  @override
  State<LogMealScreen> createState() => _LogMealScreenState();
}

class _LogMealScreenState extends State<LogMealScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  late MealProvider _mealProvider;
  late UserMealsProvider _userMealsProvider;

  Map<String, dynamic> _initialValue = {};
  SearchResult<Meal>? meals;

  List<Meal> suggestedMeals = List.empty(growable: true);
  List<Meal> cachedMeals = List.empty(growable: true);
  Meal? selectedMeal;

  bool isLoading = true;
  Timer? _searchTimer;

  @override
  void initState() {
    super.initState();
    _mealProvider = context.read<MealProvider>();
    _userMealsProvider = context.read<UserMealsProvider>();
    _initialValue = {
      "servings": "0",
    };
    initForm();
  }

  @override
  void dispose() {
    _searchTimer?.cancel();
    super.dispose();
  }

  Future initForm() async {
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(child: _buildScreen());
  }

  Widget _buildScreen() {
    return Column(children: [
      _drawSearchBar(),
      const SizedBox(height: 30),
      _drawMealCard(selectedMeal),
      FormBuilder(
          key: _formKey,
          initialValue: _initialValue,
          child: FormHelpers.drawNumericContainer(
              "Number of servings", "servings")),
      _drawSubmitButton(),
    ]);
  }

  Widget _drawSearchBar() {
    return Padding(
        padding: const EdgeInsets.all(8),
        child: Container(
            decoration: const BoxDecoration(color: Colors.white),
            child: Autocomplete<String>(
              optionsBuilder: (textEditingValue) =>
                  _optionsBuilder(textEditingValue),
              displayStringForOption: (String suggestion) => suggestion,
              optionsViewBuilder: (BuildContext context, onSelected, options) =>
                  _drawSuggestionBox(context, onSelected, options),
              onSelected: (String selection) {
                var meal = cachedMeals.firstWhere(
                  (meal) => meal.name?.toLowerCase() == selection.toLowerCase(),
                );

                setState(() {
                  selectedMeal = meal;
                });
              },
            )));
  }

  FutureOr<Iterable<String>> _optionsBuilder(
      TextEditingValue textEditingValue) {
    var searchText = textEditingValue.text;
    _searchTimer?.cancel();
    _searchTimer = Timer(const Duration(milliseconds: 250), () {
      if (searchText.length >= 3) {
        _performSearch(searchText);
      } else {
        setState(() {
          meals?.result = [];
          meals?.meta.count = 0;
        });
      }
    });
    return meals?.result.map((meal) => meal.name ?? "") ?? {};
  }

  void _performSearch(String text) async {
    var searchResultCached = cachedMeals.where((meal) =>
        meal.name?.toLowerCase().startsWith(text.toLowerCase()) ?? false);
    if (searchResultCached.isNotEmpty) {
      setState(() {
        meals?.result = searchResultCached.take(3).toList();
        meals?.meta.count = meals?.result.length ?? 3;
      });
      return;
    }
    try {
      var apiMeals = await _mealProvider.get(filter: {'name': text});
      cachedMeals.addAll(apiMeals.result.where((meal) =>
          !cachedMeals.any((cachedMeal) => cachedMeal.name == meal.name)));
      setState(() {
        meals = apiMeals;
      });
    } on Exception catch (e) {
      if (context.mounted) {
        AlertHelpers.showAlert(context, "Error", e.toString());
      }
    }
  }

  Widget _drawSuggestionBox(context, onSelected, options) {
    return Align(
      alignment: Alignment.topLeft,
      child: Material(
        elevation: 4.0,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 200, maxWidth: 250),
          child: ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemCount: options.length,
            itemBuilder: (BuildContext context, int index) {
              final String option = options.elementAt(index);
              return InkWell(
                onTap: () {
                  onSelected(option);
                },
                child: Container(
                  color: Theme.of(context).focusColor,
                  padding: const EdgeInsets.all(16.0),
                  child: Text(option),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _drawMealCard(Meal? meal) {
    if (meal != null) {
      return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: const BoxDecoration(color: Colors.white),
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
            ),
          ));
    } else {
      return Container();
    }
  }

  Widget _drawSubmitButton() {
    return ElevatedButton(
        style: const ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(Colors.white)),
        onPressed: () async {
          _formKey.currentState?.saveAndValidate();
          if (!_formKey.currentState!.isValid) return;
          Map<String, dynamic> request = Map.from(_formKey.currentState!.value);

          var userLogRequest = {
            "userId": UserInfo.user!.generalUserId!,
            "mealId": selectedMeal!.mealId,
            "dateConsumed": DateTime.now().toIso8601String(),
            "servings": request['servings'],
          };

          try {
            await _userMealsProvider.insert(userLogRequest);
          } on Exception catch (e) {
            if (context.mounted) {
              AlertHelpers.showAlert(context, "Error", e.toString());
            }
          }

          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const HomeScreen()),
              ModalRoute.withName('HomeScreen'));
        },
        child: const Text("Next"));
  }
}
