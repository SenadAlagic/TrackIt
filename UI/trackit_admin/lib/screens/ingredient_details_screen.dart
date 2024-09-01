import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

import '../models/Ingredient/ingredient.dart';
import '../providers/ingredient_provider.dart';
import '../utils/alert_helpers.dart';
import '../utils/form_helpers.dart';
import '../utils/image_helpers.dart';
import 'master_screen.dart';

class IngredientDetailsScreen extends StatefulWidget {
  final Ingredient? ingredient;
  final Function(Ingredient ingredient)? onItemAdded;
  final Function(Ingredient ingredient)? onItemUpdated;
  const IngredientDetailsScreen(
      {super.key, this.ingredient, this.onItemAdded, this.onItemUpdated});

  @override
  State<IngredientDetailsScreen> createState() =>
      _IngredientDetailsScreenState();
}

class _IngredientDetailsScreenState extends State<IngredientDetailsScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  Map<String, dynamic> _initialValue = {};
  late IngredientProvider _ingredientProvider;

  File? _image;
  String _base64Image = "";

  @override
  void initState() {
    super.initState();
    _initialValue = {
      "name": widget.ingredient?.name.toString(),
      "image": widget.ingredient?.image.toString(),
      "protein": widget.ingredient?.protein.toString(),
      "fat": widget.ingredient?.fat.toString(),
      "carbs": widget.ingredient?.carbs.toString(),
      "calories": widget.ingredient?.calories.toString(),
    };
    _base64Image = widget.ingredient?.image ?? "";
    _ingredientProvider = context.read<IngredientProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      title: "Ingredient details",
      child: _buildScreen(),
    );
  }

  Widget _buildScreen() {
    return FormBuilder(
        key: _formKey,
        initialValue: _initialValue,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          widget.ingredient != null
              ? _drawIngredientCard(widget.ingredient!)
              : const SizedBox(height: 10),
          Center(
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              FormHelpers.drawStringContainer("Ingredient name", "name",
                  maxLength: 50),
              FormHelpers.drawNumericContainer("Protein", "protein",
                  allowNegative: true),
              FormHelpers.drawNumericContainer("Calories", "calories",
                  allowNegative: true),
              FormHelpers.drawNumericContainer("Fat", "fat",
                  allowNegative: true),
              FormHelpers.drawNumericContainer("Carbs", "carbs",
                  allowNegative: true),
            ]),
            const SizedBox(width: 10),
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [_drawImagePreview("Ingredient image")])
          ])),
          const SizedBox(height: 30),
          _drawSubmitButton()
        ]));
  }

  Widget _drawIngredientCard(Ingredient ingredient) {
    return Card(
      child: Row(children: [
        const SizedBox(
          height: 80,
        ),
        Padding(
            padding: const EdgeInsets.only(left: 16, right: 16.0),
            child: ImageHelpers.getImage(ingredient.image)),
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
            onTap: () => {_ingredientProvider.delete(ingredient.ingredientId!)},
            child: const Icon(Icons.delete_outline)),
        const SizedBox(
          width: 16,
        )
      ]),
    );
  }

  String getNutritionalInformation(Ingredient ingredient) =>
      "Fat (per 100g) ${ingredient.fat}, Protein (per 100g) ${ingredient.protein}, Calories (per 100g) ${ingredient.calories}, Carbs (per 100g) ${ingredient.carbs}";

  Widget _drawImagePreview(String hint) {
    return Container(
        color: Colors.white,
        alignment: Alignment.center,
        constraints: const BoxConstraints(maxHeight: 281, maxWidth: 300),
        child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(children: [
              Text(hint),
              FormBuilderField(
                  builder: ((field) {
                    return ImageHelpers.getImage(_base64Image);
                  }),
                  name: 'image'),
              ListTile(
                  leading: const Icon(Icons.photo),
                  title: const Text("Select image"),
                  trailing: const Icon(Icons.file_upload),
                  onTap: getImage)
            ])));
  }

  Widget _drawSubmitButton() {
    return ElevatedButton(
      style: const ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(Colors.white)),
      onPressed: () async {
        _formKey.currentState?.saveAndValidate();
        if (!_formKey.currentState!.isValid) return;
        var request = Map.from(_formKey.currentState!.value);
        request['image'] = _base64Image == "" ? null : _base64Image;

        try {
          if (widget.ingredient == null) {
            var addedIngredient = await _ingredientProvider.insert(request);
            if (widget.onItemAdded != null) {
              widget.onItemAdded!(addedIngredient);
            }
            Navigator.of(context).pop();
          } else {
            var updatedIngredient = await _ingredientProvider.update(
                widget.ingredient!.ingredientId!, request);
            if (widget.onItemUpdated != null) {
              widget.onItemUpdated!(updatedIngredient);
            }
            Navigator.of(context).pop();
          }
        } on Exception catch (e) {
          if (context.mounted) {
            AlertHelpers.showAlert(context, "Error", e.toString());
          }
        }
      },
      child: Padding(
          padding: const EdgeInsets.all(4),
          child: Text(widget.ingredient != null
              ? "Edit ingredient"
              : "Add a new ingredient")),
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
