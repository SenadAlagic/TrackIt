import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';
import 'package:trackit_admin/utils/alert_helpers.dart';
import 'package:trackit_admin/utils/string_helpers.dart';

import '../models/Tag/tag.dart';
import '../models/search_result.dart';
import '../providers/tag_provider.dart';
import 'master_screen.dart';

class ManageTagsScreen extends StatefulWidget {
  const ManageTagsScreen({super.key});

  @override
  State<ManageTagsScreen> createState() => _ManageTagsScreenState();
}

class _ManageTagsScreenState extends State<ManageTagsScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  Map<String, dynamic> _initialValue = {};

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
    var result = await _tagProvider.get();

    setState(() {
      tags = result;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      title: "Manage tags",
      child: isLoading ? Container() : _buildScreen(),
    );
  }

  Widget _buildScreen() {
    if (tags?.result.isNotEmpty ?? false) {
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
                    children: [
                      ...tags!.result.map((tag) => _drawListTile(tag))
                    ],
                  ))))),
          _drawNewTagButton()
        ],
      ));
    } else {
      return const CircularProgressIndicator();
    }
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
                  showDialog(
                      context: context,
                      builder: (BuildContext context) =>
                          _builder(context, tag: tag));
                },
                child: const Icon(Icons.create_outlined)),
            InkWell(
                onTap: () => {_tagProvider.delete(tag.tagId!)},
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
            onPressed: () async {
              _formKey.currentState?.saveAndValidate();
              if (!_formKey.currentState!.isValid) return;
              var request = Map.from(_formKey.currentState!.value);

              request['color'] =
                  "#${request['color'].toString().substring(4).toUpperCase()}";

              try {
                if (tag != null) {
                  await _tagProvider.update(tag.tagId!, request);
                } else {
                  await _tagProvider.insert(request);
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
          backgroundColor: MaterialStatePropertyAll(Colors.white)),
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

  Widget _drawStringContainer(String hint, String propertyName,
      {bool enabled = true}) {
    return Container(
      color: Colors.white,
      alignment: Alignment.centerLeft,
      constraints: const BoxConstraints(maxHeight: 71, maxWidth: 300),
      child: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8),
          child: Column(children: [
            FormBuilderTextField(
              enabled: enabled,
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

  Widget _buildForm() {
    return FormBuilder(
        key: _formKey,
        initialValue: _initialValue,
        child: SizedBox(
          height: 313,
          child: Column(children: [
            _drawStringContainer("Tag name", "name"),
            _drawStringContainer("Tag description", "description"),
            _drawStringContainer("Tag color", "color", enabled: false),
            _drawColorOptions()
          ]),
        ));
  }

  Widget _drawColorOptions() {
    return SizedBox(
      height: 100,
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        _drawColorTile(0xFF2196F3),
        _drawColorTile(0xFFF44336),
        _drawColorTile(0xFFFFF176),
        _drawColorTile(0xFF66BB6A),
        _drawColorTile(0xFFF48FB1),
      ]),
    );
  }

  Widget _drawColorTile(int colorValue) {
    return InkWell(
      onTap: () {
        _formKey.currentState?.fields['color']!
            .didChange("0x${colorValue.toRadixString(16)}");
      },
      child: Container(
        margin: const EdgeInsets.all(5.0),
        height: 40,
        width: 40,
        color: Color(colorValue),
      ),
    );
  }
}
