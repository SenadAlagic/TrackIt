import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';
import 'package:trackit_admin/models/MealIngredient/meal_ingredient.dart';
import 'package:trackit_admin/models/search_result.dart';
import 'package:trackit_admin/providers/meal_provider.dart';
import 'package:trackit_admin/screens/master_screen.dart';

import '../models/Ingredient/ingredient.dart';
import '../models/Meal/meal.dart';
import '../providers/ingredient_provider.dart';
import '../utils/alert_helpers.dart';

class MealDetailsScreen extends StatefulWidget {
  final Meal? meal;

  const MealDetailsScreen({super.key, this.meal});

  @override
  State<MealDetailsScreen> createState() => _MealDetailsScreenState();
}

class _MealDetailsScreenState extends State<MealDetailsScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  final _searchFieldController = TextEditingController();
  Timer? _searchTimer;
  Map<String, dynamic> _initialValue = {};

  late MealProvider _mealProvider;
  late IngredientProvider _ingredientProvider;

  SearchResult<Ingredient>? ingredients;
  List<Ingredient> suggestedIngredients = List.empty(growable: true);
  List<Ingredient> cachedIngredients = List.empty(growable: true);
  List<MealIngredient> selectedIngredients = List.empty(growable: true);

  bool isLoading = true;

  File? _image;
  String _base64Image = "";

  @override
  void initState() {
    super.initState();
    _initialValue = {
      'name': widget.meal?.name,
      'description': widget.meal?.description,
      'image': widget.meal?.image,
    };

    List<MealIngredient> fetchedIngredients =
        widget.meal?.mealsIngredients ?? [];
    if (fetchedIngredients.isNotEmpty) {
      selectedIngredients = fetchedIngredients;
    }
    _base64Image = widget.meal?.image ?? "";
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
    return MasterScreen(
      title: "Meal details",
      child: _buildScreen(),
    );
  }

  Widget _buildScreen() {
    return FormBuilder(
      key: _formKey,
      initialValue: _initialValue,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              _drawStringContainer("Meal name", "name"),
              const SizedBox(height: 10),
              _drawLargeContainer("Meal description"),
              const SizedBox(height: 10),
              _drawImagePreview("Meal image")
            ]),
            const SizedBox(width: 10),
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [_drawTable()])
          ])),
          const SizedBox(height: 30),
          _drawSubmitButton()
        ],
      ),
    );
  }

  Widget _drawTable() {
    return FormBuilderField(
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
          return SizedBox(
              width: 450,
              child: InputDecorator(
                  decoration: InputDecoration(
                      border: InputBorder.none, errorText: field.errorText),
                  child: Container(
                      decoration: const BoxDecoration(color: Colors.white),
                      constraints: const BoxConstraints(
                          maxHeight: 400, minWidth: 450, maxWidth: 450),
                      child: SingleChildScrollView(
                        child: DataTable(columns: [
                          DataColumn(
                              label: ConstrainedBox(
                                  constraints:
                                      const BoxConstraints(maxWidth: 100),
                                  child: const Text('Quantity'))),
                          DataColumn(
                              label: ConstrainedBox(
                                  constraints:
                                      const BoxConstraints(minWidth: 200),
                                  child: const Text('Name'))),
                          DataColumn(
                              label: ConstrainedBox(
                                  constraints:
                                      const BoxConstraints(maxWidth: 50),
                                  child: const Text('')))
                        ], rows: [
                          ...selectedIngredients.map((MealIngredient
                                  mealIngredient) =>
                              DataRow(cells: [
                                DataCell(TextFormField(
                                  initialValue: mealIngredient
                                      .ingredientQuantity
                                      .toString(),
                                  onChanged: (value) {
                                    var index = selectedIngredients.indexWhere(
                                        (element) =>
                                            element.ingredientId ==
                                            mealIngredient.ingredientId);
                                    if (index != -1) {
                                      selectedIngredients[index]
                                              .ingredientQuantity =
                                          int.tryParse(value) ?? 0;
                                    }
                                  },
                                )),
                                DataCell(Text(
                                    mealIngredient.ingredient?.name ?? "")),
                                DataCell(
                                  InkWell(
                                      onTap: () {
                                        setState(() {
                                          selectedIngredients.removeWhere(
                                              (ingredient) =>
                                                  ingredient.ingredient?.name ==
                                                  mealIngredient
                                                      .ingredient?.name);
                                        });
                                      },
                                      child: const Icon(Icons.delete_outline)),
                                ),
                              ])),
                          DataRow(cells: [
                            const DataCell(TextField(
                              decoration: InputDecoration(hintText: "Quantity"),
                            )),
                            DataCell(Autocomplete<String>(
                              optionsBuilder: (textEditingValue) =>
                                  _optionsBuilder(textEditingValue),
                              displayStringForOption: (String suggestion) =>
                                  suggestion,
                              optionsViewBuilder:
                                  (BuildContext context, onSelected, options) =>
                                      _drawSuggestionBox(
                                          context, onSelected, options),
                              onSelected: (String selection) {
                                var selectedIngredient =
                                    cachedIngredients.firstWhere(
                                  (ingredient) =>
                                      ingredient.name?.toLowerCase() ==
                                      selection.toLowerCase(),
                                );

                                var existingElement = selectedIngredients.where(
                                    (ingredient) => selectedIngredients.any(
                                        (ingredient) =>
                                            ingredient.ingredient?.name ==
                                            selectedIngredient.name));

                                if (existingElement.isEmpty) {
                                  setState(() {
                                    selectedIngredients.add(MealIngredient(
                                        0,
                                        0,
                                        selectedIngredient.ingredientId,
                                        0,
                                        selectedIngredient));
                                  });
                                }
                              },
                            )),
                            const DataCell(Text("")),
                          ])
                        ]),
                      ))));
        });
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

    var apiIngredients = await _ingredientProvider.get(filter: {'name': text});
    cachedIngredients.addAll(apiIngredients.result.where((ingredient) =>
        !cachedIngredients.any(
            (cachedIngredient) => cachedIngredient.name == ingredient.name)));
    setState(() {
      ingredients = apiIngredients;
    });
  }

  Widget _drawImagePreview(String hint) {
    return Container(
        color: Colors.white,
        alignment: Alignment.center,
        constraints: const BoxConstraints(maxHeight: 294, maxWidth: 300),
        child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(children: [
              Text(hint),
              FormBuilderField(
                  builder: ((field) {
                    return _base64Image != ""
                        ? Image.memory(
                            base64Decode(_base64Image),
                            height: 200,
                            width: 200,
                          )
                        : Image.asset(
                            "assets/images/NoImageFound.jpg",
                            height: 200,
                            width: 200,
                          );
                  }),
                  name: 'image'),
              ListTile(
                  leading: const Icon(Icons.photo),
                  title: const Text("Select image"),
                  trailing: const Icon(Icons.file_upload),
                  onTap: getImage)
            ])));
  }

  Widget _drawStringContainer(String hint, String propertyName) {
    return Container(
      color: Colors.white,
      alignment: Alignment.centerLeft,
      constraints: const BoxConstraints(maxHeight: 71, maxWidth: 300),
      child: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8),
          child: Column(children: [
            FormBuilderTextField(
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(errorText: "Field is required")
              ]),
              name: propertyName,
              decoration: InputDecoration(
                hintText: "$hint*",
              ),
            )
          ])),
    );
  }

  Widget _drawLargeContainer(String hint) {
    return Container(
      color: Colors.white,
      alignment: Alignment.centerLeft,
      constraints: const BoxConstraints(maxHeight: 255, maxWidth: 300),
      child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(children: [
            FormBuilderTextField(
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(errorText: "Field is required."),
                FormBuilderValidators.maxLength(30,
                    errorText: "Field must contain less than 30 characters")
              ]),
              name: 'description',
              keyboardType: TextInputType.multiline,
              maxLines: 10,
              decoration: InputDecoration(
                hintText: "$hint*",
              ),
            )
          ])),
    );
  }

  Widget _drawSubmitButton() {
    return ElevatedButton(
      style: const ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(Colors.white)),
      onPressed: () async {
        _formKey.currentState?.saveAndValidate();
        if (!_formKey.currentState!.isValid) return;
        var formInfo = Map.from(_formKey.currentState!.value);
        formInfo['image'] = _base64Image == "" ? null : _base64Image;

        var mealRequest = {
          "name": formInfo['name'],
          "description": formInfo['description'],
          "image": formInfo['image'],
        };

        try {
          dynamic response;
          if (widget.meal == null) {
            response = await _mealProvider.insert(mealRequest);
          } else {
            response =
                await _mealProvider.update(widget.meal!.mealId!, mealRequest);
          }
          var ingredientsArray = selectedIngredients
              .map((element) => {
                    "ingredientId": element.ingredientId,
                    "quantity": element.ingredientQuantity
                  })
              .toList();
          await _mealProvider.setIngredients(
              response.mealId, jsonEncode(ingredientsArray));
          Navigator.of(context).pop();
        } on Exception catch (e) {
          if (context.mounted) {
            AlertHelpers.showAlert(context, "Error", e.toString());
          }
        }
      },
      child: const Padding(
          padding: EdgeInsets.all(4), child: Text("Add a new meal")),
    );
  }

  Future getImage() async {
    var result = await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null && result.files.single.path != null) {
      _image = File(result.files.single.path!);
      setState(() {
        _base64Image = base64Encode(_image!.readAsBytesSync());
      });
    }
  }
}
