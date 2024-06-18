import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

import '../models/ActivityLevel/activity_level.dart';
import '../providers/activity_level_provider.dart';
import '../utils/alert_helpers.dart';
import '../utils/form_helpers.dart';
import '../utils/image_helpers.dart';
import 'master_screen.dart';

class ActivityLevelDetailsScreen extends StatefulWidget {
  final ActivityLevel? activityLevel;
  const ActivityLevelDetailsScreen({super.key, this.activityLevel});

  @override
  State<ActivityLevelDetailsScreen> createState() =>
      _ActivityLevelDetailsScreenState();
}

class _ActivityLevelDetailsScreenState
    extends State<ActivityLevelDetailsScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  Map<String, dynamic> _initialValue = {};
  late ActivityLevelProvider _activityLevelProvider;

  File? _image;
  String _base64Image = "";

  @override
  void initState() {
    super.initState();
    _initialValue = {
      "name": widget.activityLevel?.name,
      "multiplier": widget.activityLevel?.multiplier.toString(),
      "image": widget.activityLevel?.image,
    };
    _base64Image = widget.activityLevel?.image ?? "";
    _activityLevelProvider = context.read<ActivityLevelProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      title: "Activity level details",
      child: _buildScreen(),
    );
  }

  Widget _buildScreen() {
    return FormBuilder(
        key: _formKey,
        initialValue: _initialValue,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          widget.activityLevel != null
              ? _drawActivityLevelCard(widget.activityLevel!)
              : const SizedBox(height: 10),
          Center(
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              FormHelpers.drawStringContainer("Activity level name", "name"),
              FormHelpers.drawNumericContainer(
                  "Activity level multiplier", "multiplier"),
            ]),
            const SizedBox(width: 10),
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [_drawImagePreview("Activity level image")])
          ])),
          const SizedBox(height: 30),
          _drawSubmitButton()
        ]));
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
          backgroundColor: MaterialStatePropertyAll(Colors.white)),
      onPressed: () async {
        _formKey.currentState?.saveAndValidate();
        if (!_formKey.currentState!.isValid) return;
        var request = Map.from(_formKey.currentState!.value);
        request['image'] = _base64Image == "" ? null : _base64Image;

        try {
          if (widget.activityLevel == null) {
            await _activityLevelProvider.insert(request);
            Navigator.of(context).pop();
          } else {
            await _activityLevelProvider.update(
                widget.activityLevel!.activityLevelId!, request);
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
          child: Text(widget.activityLevel != null
              ? "Edit activity level"
              : "Add a new activity level")),
    );
  }

  Widget _drawActivityLevelCard(ActivityLevel activityLevel) {
    return Card(
      child: Row(children: [
        const SizedBox(
          height: 80,
        ),
        Padding(
            padding: const EdgeInsets.only(left: 16, right: 16.0),
            child: ImageHelpers.getImage(activityLevel.image)),
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              activityLevel.name ?? "",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text("${activityLevel.multiplier}x")
          ],
        )),
        InkWell(
            onTap: () => {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const ActivityLevelDetailsScreen()))
                },
            child: const Icon(Icons.create_outlined)),
        InkWell(
            onTap: () =>
                {_activityLevelProvider.delete(activityLevel.activityLevelId!)},
            child: const Icon(Icons.delete_outline)),
        const SizedBox(
          width: 16,
        )
      ]),
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
