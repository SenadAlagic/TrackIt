import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';
import 'package:trackit_mobile/models/UserPreferences/user_preferences.dart';
import 'package:trackit_mobile/utils/user_info.dart';

import '../models/Preference/preference.dart';
import '../models/search_result.dart';
import '../providers/general_user_provider.dart';
import '../providers/preference_provider.dart';
import '../utils/authorization.dart';
import '../utils/form_helpers.dart';

class EditPreferencesScreen extends StatefulWidget {
  const EditPreferencesScreen({super.key});

  @override
  State<EditPreferencesScreen> createState() => _EditPreferencesScreenState();
}

class _EditPreferencesScreenState extends State<EditPreferencesScreen> {
  late PreferenceProvider _preferenceProvider;
  late GeneralUserProvider _generalUserProvider;
  SearchResult<Preference>? preferences;
  List<int> selectedPreferences = List.empty(growable: true);
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _preferenceProvider = context.read<PreferenceProvider>();
    _generalUserProvider = context.read<GeneralUserProvider>();
    initScreen();
  }

  Future initScreen() async {
    var result = await _preferenceProvider.get();
    setState(() {
      preferences = result;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(child: SingleChildScrollView(child: _drawScreen())),
    );
  }

  Widget _drawScreen() {
    if (preferences?.result.isNotEmpty ?? false) {
      return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(children: [
            SingleChildScrollView(
                child: IntrinsicHeight(
                    child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Text(
                    "Select your preferences",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                _drawPreferenceCheckBoxGroup(preferences!.result),
                _drawSubmitButton()
              ],
            ))),
          ]));
    } else {
      return FormHelpers.drawProgressIndicator();
    }
  }

  dynamic _drawPreferenceCheckBoxGroup(List<Preference> preferences) {
    var initialValue = UserInfo.user!.usersPreferences!
        .map((UserPreferences userPreference) => userPreference.preferenceId!)
        .toList();
    return FormBuilderCheckboxGroup(
      name: "preferences",
      initialValue: initialValue,
      onChanged: (value) =>
          {selectedPreferences = value!.map((value) => value).toList()},
      options: preferences
          .map((Preference preference) => FormBuilderFieldOption<int>(
                value: preference.preferenceId!,
                child: Text(preference.name ?? ""),
              ))
          .toList(),
      decoration: const InputDecoration(
        border: InputBorder.none,
      ),
      checkColor: Colors.black,
    );
  }

  Widget _drawSubmitButton() {
    return ElevatedButton(
        style: const ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(Colors.white)),
        onPressed: () async {
          var user = await _generalUserProvider.addPreferences(
              Authorization.generalUserId!, selectedPreferences);
          user = await _generalUserProvider.getFullInfo(user!.generalUserId!);
          UserInfo.user = user;
          Navigator.of(context).pop();
        },
        child: const Text("Finish registration"));
  }
}
