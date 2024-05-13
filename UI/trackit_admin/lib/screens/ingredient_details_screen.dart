import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';
import 'package:trackit_admin/providers/ingredient_provider.dart';

import '../models/Ingredient/ingredient.dart';
import '../utils/alert_helpers.dart';
import 'master_screen.dart';

class IngredientDetailsScreen extends StatefulWidget {
  final Ingredient? ingredient;
  const IngredientDetailsScreen({super.key, this.ingredient});

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
              _drawStringContainer("Ingredient name", "name"),
              _drawNumericContainer("Protein", "protein"),
              _drawNumericContainer("Calories", "calories"),
              _drawNumericContainer("Fat", "fat"),
              _drawNumericContainer("Carbs", "carbs"),
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
            child: ingredient.image?.isNotEmpty ?? true
                ? Image.memory(
                    base64Decode(ingredient.image!),
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

  Widget _drawNumericContainer(String hint, String propertyName) {
    return Container(
      color: Colors.white,
      alignment: Alignment.centerLeft,
      constraints: const BoxConstraints(maxHeight: 71, maxWidth: 300),
      child: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8),
          child: Column(children: [
            FormBuilderTextField(
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(errorText: "Field is required"),
                FormBuilderValidators.numeric(
                    errorText: "Field must be numeric")
              ]),
              keyboardType: TextInputType.number,
              name: propertyName,
              decoration: InputDecoration(
                hintText: "$hint*",
              ),
            )
          ])),
    );
  }

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

  Widget _drawSubmitButton() {
    return ElevatedButton(
      style: const ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(Colors.white)),
      onPressed: () async {
        _formKey.currentState?.saveAndValidate();
        if (!_formKey.currentState!.isValid) return;
        var request = Map.from(_formKey.currentState!.value);
        request['image'] = _base64Image == "" ? null : _base64Image;

        try {
          if (widget.ingredient == null) {
            await _ingredientProvider.insert(request);
            Navigator.of(context).pop();
          } else {
            await _ingredientProvider.update(
                widget.ingredient!.ingredientId!, request);
            Navigator.of(context).pop();
          }
        } on Exception catch (e) {
          if (context.mounted) {
            AlertHelpers.showAlert(context, "Error", e.toString());
          }
        }
      },
      child: const Padding(
          padding: EdgeInsets.all(4), child: Text("Add a new ingredient")),
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
