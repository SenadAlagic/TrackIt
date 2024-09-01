import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';

import '../models/Tag/tag.dart';
import '../models/search_result.dart';
import '../providers/tag_provider.dart';
import '../utils/alert_helpers.dart';
import '../utils/form_helpers.dart';
import '../utils/string_helpers.dart';
import 'master_screen.dart';

class ManageTagsScreen extends StatefulWidget {
  const ManageTagsScreen({super.key});

  @override
  State<ManageTagsScreen> createState() => _ManageTagsScreenState();
}

class _ManageTagsScreenState extends State<ManageTagsScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  Map<String, dynamic> _initialValue = {};

  int? _selectedColor = 0xFF66CC99;
  late TagProvider _tagProvider;
  SearchResult<Tag>? tags;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _initialValue = {"name": "", "description": "", "color": ""};
    _tagProvider = context.read<TagProvider>();
    initScreen();
  }

  Future initScreen() async {
    try {
      var result = await _tagProvider.get(filter: {'Page': 0, "PageSize": 30});

      setState(() {
        tags = result;
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
      title: "Manage tags",
      child: isLoading ? FormHelpers.drawProgressIndicator() : _buildScreen(),
    );
  }

  Widget _buildScreen() {
    return Center(
        child: Column(
      children: [
        Card(
            child: SizedBox(
                height: 400,
                width: 300,
                child: SingleChildScrollView(
                    child: IntrinsicHeight(
                        child: Column(
                  children: [...tags!.result.map((tag) => _drawListTile(tag))],
                ))))),
        _drawNewTagButton()
      ],
    ));
  }

  Widget _drawListTile(Tag tag) {
    return ListTile(
      title: Text(tag.name ?? ""),
      leading: SizedBox(
          height: 20,
          width: 20,
          child: Container(color: StringHelpers.colorFromHex(tag.color!))),
      trailing: SizedBox(
          width: 50,
          child: Row(children: [
            InkWell(
                onTap: () {
                  _initialValue = {
                    "name": tag.name,
                    "description": tag.description,
                    "color": tag.color
                  };
                  _selectedColor =
                      StringHelpers.intFromColor(_initialValue['color']);

                  showDialog(
                      context: context,
                      builder: (BuildContext context) =>
                          _builder(context, tag: tag));
                },
                child: const Icon(Icons.create_outlined)),
            InkWell(
                onTap: () {
                  _tagProvider.delete(tag.tagId!);
                  setState(() {
                    tags!.result.remove(tag);
                    tags!.meta.count -= 1;
                  });
                },
                child: const Icon(Icons.delete_outlined))
          ])),
    );
  }

  Widget _builder(BuildContext context, {Tag? tag}) {
    return AlertDialog(
      title: Text(tag == null ? "Add a new tag" : "Edit tag"),
      content: _buildForm(),
      actions: [
        TextButton(
            style: const ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Colors.yellow),
                textStyle: WidgetStatePropertyAll(TextStyle(
                    color: Colors.black, backgroundColor: Colors.white))),
            onPressed: () async {
              _formKey.currentState?.saveAndValidate();
              if (!_formKey.currentState!.isValid) return;
              var request = Map.from(_formKey.currentState!.value);

              request['color'] =
                  "#${_selectedColor?.toRadixString(16).substring(2).toUpperCase()}";

              try {
                if (tag == null) {
                  var addedTag = await _tagProvider.insert(request);
                  setState(() {
                    tags!.result.add(addedTag);
                    tags!.meta.count += 1;
                  });
                } else {
                  var updatedTag =
                      await _tagProvider.update(tag.tagId!, request);
                  var updatedTags = tags;
                  var indexOf = updatedTags!.result
                      .indexWhere((Tag tag) => tag.tagId == updatedTag.tagId);
                  updatedTags.result[indexOf] = updatedTag;
                  setState(() {
                    tags = updatedTags;
                  });
                }
              } on Exception catch (e) {
                if (context.mounted) {
                  AlertHelpers.showAlert(context, "Error", e.toString());
                }
              }
              Navigator.pop(context);
            },
            child: const Text("OK"))
      ],
    );
  }

  Widget _drawNewTagButton() {
    return ElevatedButton(
      style: const ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(Colors.white)),
      onPressed: () async {
        _initialValue = {"name": "", "description": "", "color": ""};
        showDialog(
            context: context,
            builder: (BuildContext context) => _builder(context));
      },
      child: const Padding(
          padding: EdgeInsets.all(4), child: Text("Add a new tag")),
    );
  }

  Widget _buildForm() {
    return FormBuilder(
        key: _formKey,
        initialValue: _initialValue,
        child: SizedBox(
          height: 313,
          child: Column(children: [
            FormHelpers.drawStringContainer("Tag name", "name", maxLength: 50),
            FormHelpers.drawStringContainer("Tag description", "description",
                maxLength: 60),
            _drawDropdownMenu(),
          ]),
        ));
  }

  Widget _drawDropdownMenu() {
    return DropdownButtonFormField<int>(
      value: _selectedColor,
      items: [
        DropdownMenuItem(value: 0xFF66CC99, child: _drawColorTile(0xFF66CC99)),
        DropdownMenuItem(value: 0xFF99CCFF, child: _drawColorTile(0xFF99CCFF)),
        DropdownMenuItem(value: 0xFFFFD700, child: _drawColorTile(0xFFFFD700)),
        DropdownMenuItem(value: 0xFFFF99CC, child: _drawColorTile(0xFFFF99CC)),
        DropdownMenuItem(value: 0xFFF9F900, child: _drawColorTile(0xFFF9F900)),
        DropdownMenuItem(value: 0xFFFF5733, child: _drawColorTile(0xFFFF5733))
      ],
      onChanged: (value) {
        setState(() {
          _selectedColor = value;
        });
      },
      validator: FormBuilderValidators.compose(
          [FormBuilderValidators.required(errorText: "Field is required")]),
    );
  }

  Widget _drawColorTile(int colorValue) {
    return Container(
      margin: const EdgeInsets.all(5.0),
      height: 40,
      width: 40,
      color: Color(colorValue),
    );
  }
}
