import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';
import 'package:trackit_mobile/utils/user_info.dart';

import '../models/Ingredient/ingredient.dart';
import '../models/MealIngredient/meal_ingredient.dart';
import '../models/search_result.dart';
import '../providers/ingredient_provider.dart';
import '../providers/meal_provider.dart';
import '../utils/alert_helpers.dart';
import 'master_screen.dart';
import 'meals_list_screen.dart';

class MealSearchScreen extends StatefulWidget {
  const MealSearchScreen({super.key});

  @override
  State<MealSearchScreen> createState() => _MealSearchScreenState();
}

class _MealSearchScreenState extends State<MealSearchScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  final _searchFieldController = TextEditingController();
  Timer? _searchTimer;

  late MealProvider _mealProvider;
  late IngredientProvider _ingredientProvider;

  SearchResult<Ingredient>? ingredients;
  List<Ingredient> suggestedIngredients = List.empty(growable: true);
  List<Ingredient> cachedIngredients = List.empty(growable: true);
  List<MealIngredient> selectedIngredients = List.empty(growable: true);

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _mealProvider = context.read<MealProvider>();
    _ingredientProvider = context.read<IngredientProvider>();
    initForm();
  }

  @override
  void dispose() {
    _searchFieldController.dispose();
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
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 16.0),
          child: Text(
            "Search for a meal idea",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
        _drawTable(),
        _drawSubmitButton(),
        const Text(
          "Keep in mind that your preferences affect search results",
          style: TextStyle(fontSize: 12),
        ),
      ],
    );
  }

  Widget _drawTable() {
    var scrollController = ScrollController();
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: FormBuilder(
          key: _formKey,
          child: FormBuilderField(
              name: "mealIngredients",
              validator: (value) {
                if (selectedIngredients.isEmpty) {
                  return "Ingredient list cannot be empty";
                }
                for (var element in selectedIngredients) {
                  if (element.ingredientQuantity! <= 0) {
                    return "Quantity must be larger than 0";
                  }
                  return null;
                }
                return null;
              },
              builder: (field) {
                return Scrollbar(
                    controller: scrollController,
                    thumbVisibility: true,
                    trackVisibility: true,
                    child: SingleChildScrollView(
                        controller: scrollController,
                        scrollDirection: Axis.horizontal,
                        child: SizedBox(
                            width: 450,
                            child: InputDecorator(
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    errorText: field.errorText),
                                child: Container(
                                    decoration: const BoxDecoration(
                                        color: Colors.white),
                                    constraints: const BoxConstraints(
                                        maxHeight: 400,
                                        minWidth: 450,
                                        maxWidth: 450),
                                    child: SingleChildScrollView(
                                      child: DataTable(columns: [
                                        DataColumn(
                                            label: ConstrainedBox(
                                                constraints:
                                                    const BoxConstraints(
                                                        maxWidth: 100),
                                                child: const Text('Quantity'))),
                                        DataColumn(
                                            label: ConstrainedBox(
                                                constraints:
                                                    const BoxConstraints(
                                                        minWidth: 200),
                                                child: const Text('Name'))),
                                        DataColumn(
                                            label: ConstrainedBox(
                                                constraints:
                                                    const BoxConstraints(
                                                        maxWidth: 50),
                                                child: const Text('')))
                                      ], rows: [
                                        ...selectedIngredients.map(
                                            (MealIngredient mealIngredient) =>
                                                DataRow(cells: [
                                                  DataCell(TextFormField(
                                                    initialValue: mealIngredient
                                                        .ingredientQuantity
                                                        .toString(),
                                                    onChanged: (value) {
                                                      var index = selectedIngredients
                                                          .indexWhere((element) =>
                                                              element
                                                                  .ingredientId ==
                                                              mealIngredient
                                                                  .ingredientId);
                                                      if (index != -1) {
                                                        selectedIngredients[
                                                                    index]
                                                                .ingredientQuantity =
                                                            int.tryParse(
                                                                    value) ??
                                                                0;
                                                      }
                                                    },
                                                  )),
                                                  DataCell(Text(mealIngredient
                                                          .ingredient?.name ??
                                                      "")),
                                                  DataCell(
                                                    InkWell(
                                                        onTap: () {
                                                          setState(() {
                                                            selectedIngredients.removeWhere(
                                                                (ingredient) =>
                                                                    ingredient
                                                                        .ingredient
                                                                        ?.name ==
                                                                    mealIngredient
                                                                        .ingredient
                                                                        ?.name);
                                                          });
                                                        },
                                                        child: const Icon(Icons
                                                            .delete_outline)),
                                                  ),
                                                ])),
                                        DataRow(cells: [
                                          const DataCell(TextField(
                                            decoration: InputDecoration(
                                                hintText: "Quantity"),
                                          )),
                                          DataCell(Autocomplete<String>(
                                            optionsBuilder:
                                                (textEditingValue) =>
                                                    _optionsBuilder(
                                                        textEditingValue),
                                            displayStringForOption:
                                                (String suggestion) =>
                                                    suggestion,
                                            optionsViewBuilder:
                                                (BuildContext context,
                                                        onSelected, options) =>
                                                    _drawSuggestionBox(context,
                                                        onSelected, options),
                                            onSelected: (String selection) {
                                              var selectedIngredient =
                                                  cachedIngredients.firstWhere(
                                                (ingredient) =>
                                                    ingredient.name
                                                        ?.toLowerCase() ==
                                                    selection.toLowerCase(),
                                              );

                                              var existingElement = selectedIngredients
                                                  .where((ingredient) =>
                                                      selectedIngredients.any(
                                                          (ingredient) =>
                                                              ingredient
                                                                  .ingredient
                                                                  ?.name ==
                                                              selectedIngredient
                                                                  .name));

                                              if (existingElement.isEmpty) {
                                                setState(() {
                                                  selectedIngredients.add(
                                                      MealIngredient(
                                                          0,
                                                          0,
                                                          selectedIngredient
                                                              .ingredientId,
                                                          0,
                                                          selectedIngredient));
                                                });
                                              }
                                            },
                                          )),
                                          const DataCell(Text("")),
                                        ])
                                      ]),
                                    ))))));
              }),
        ));
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
          ingredients?.result = [];
          ingredients?.meta.count = 0;
        });
      }
    });
    return ingredients?.result.map((ingredient) => ingredient.name ?? "") ?? {};
  }

  void _performSearch(String text) async {
    var searchResultCached = cachedIngredients.where((ingredient) =>
        ingredient.name?.toLowerCase().startsWith(text.toLowerCase()) ?? false);
    if (searchResultCached.isNotEmpty) {
      setState(() {
        ingredients?.result = searchResultCached.take(3).toList();
        ingredients?.meta.count = ingredients?.result.length ?? 3;
      });
      return;
    }
    try {
      var apiIngredients =
          await _ingredientProvider.get(filter: {'name': text});
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

  Widget _drawSubmitButton() {
    return ElevatedButton(
      style: const ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(Colors.white)),
      onPressed: () async {
        _formKey.currentState?.saveAndValidate();
        if (!_formKey.currentState!.isValid) return;

        print(selectedIngredients);
        List<int> ingredientIds = selectedIngredients
            .map((MealIngredient selectedIngredient) =>
                selectedIngredient.ingredientId!)
            .toList();

        try {
          var preferences = UserInfo.user!.usersPreferences!
              .map((preference) => preference.preference!.name)
              .toList();

          var resultingMeals = await _mealProvider.get(filter: {
            "IngredientIds": ingredientIds,
            "Preferences": preferences
          });
          Navigator.of(context).push(MaterialPageRoute(
              builder: (builder) =>
                  MealsListScreen(meals: resultingMeals.result)));
        } on Exception catch (e) {
          if (context.mounted) {
            AlertHelpers.showAlert(context, "Error", e.toString());
          }
        }
      },
      child: const Padding(padding: EdgeInsets.all(4), child: Text("Search")),
    );
  }
}
