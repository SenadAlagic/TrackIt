import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';
import 'package:trackit_admin/providers/goal_provider.dart';
import 'package:trackit_admin/utils/alert_helpers.dart';

import '../models/Goal/goal.dart';
import 'master_screen.dart';

class GoalDetailsScreen extends StatefulWidget {
  final Goal? goal;
  const GoalDetailsScreen({super.key, this.goal});

  @override
  State<GoalDetailsScreen> createState() => _GoalDetailsScreenState();
}

class _GoalDetailsScreenState extends State<GoalDetailsScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  Map<String, dynamic> _initialValue = {};
  late GoalProvider _goalProvider;

  File? _image;
  String _base64Image = "";

  @override
  void initState() {
    super.initState();
    _initialValue = {
      'name': widget.goal?.name,
      'description': widget.goal?.description,
      'image': widget.goal?.image,
      'targetProtein': widget.goal?.targetProtein.toString(),
      'targetCalories': widget.goal?.targetCalories.toString()
    };
    _base64Image = widget.goal?.image ?? "";
    _goalProvider = context.read<GoalProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      title: "Goal details",
      child: _buildScreen(),
    );
  }

  Widget _buildScreen() {
    return FormBuilder(
        key: _formKey,
        initialValue: _initialValue,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          widget.goal != null
              ? _drawGoalCard(widget.goal!)
              : const SizedBox(height: 10),
          Center(
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              _drawStringContainer("Goal name", "name"),
              _drawNumericContainer("Target protein", "targetProtein"),
              _drawNumericContainer("Target calories", "targetCalories"),
              const SizedBox(height: 10),
              _drawLargeContainer("Goal description")
            ]),
            const SizedBox(width: 10),
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [_drawImagePreview("Goal image")])
          ])),
          const SizedBox(height: 30),
          _drawSubmitButton()
        ]));
  }

  Widget _drawGoalCard(Goal goal) {
    return Card(
      child: Row(children: [
        const SizedBox(
          height: 80,
        ),
        Padding(
            padding: const EdgeInsets.only(left: 16, right: 16.0),
            child: goal.image?.isNotEmpty ?? true
                ? Image.memory(
                    base64Decode(goal.image!),
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
              goal.name ?? "",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(goal.description ?? "")
          ],
        )),
        InkWell(
            onTap: () => {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => GoalDetailsScreen(goal: goal)))
                },
            child: const Icon(Icons.create_outlined)),
        InkWell(
            onTap: () => {_goalProvider.delete(goal.goalId!)},
            child: const Icon(Icons.delete_outline)),
        const SizedBox(
          width: 16,
        )
      ]),
    );
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

  Widget _drawLargeContainer(String hint) {
    return Container(
      color: Colors.white,
      alignment: Alignment.centerLeft,
      constraints: const BoxConstraints(maxHeight: 272, maxWidth: 300),
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
          if (widget.goal == null) {
            await _goalProvider.insert(request);
            Navigator.of(context).pop();
          } else {
            await _goalProvider.update(widget.goal!.goalId!, request);
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
          child: Text(widget.goal != null ? "Edit goal" : "Add a new goal")),
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