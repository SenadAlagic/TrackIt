import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';
import 'package:trackit_mobile/models/User/user.dart';
import 'package:trackit_mobile/models/UserData/user_data.dart';
import 'package:trackit_mobile/providers/general_user_provider.dart';
import 'package:trackit_mobile/screens/home_screen.dart';

import '../models/Preference/preference.dart';
import '../models/search_result.dart';
import '../providers/auth_provider.dart';
import '../providers/preference_provider.dart';
import '../utils/authorization.dart';

class AddPreferencesScreen extends StatefulWidget {
  const AddPreferencesScreen({super.key});

  @override
  State<AddPreferencesScreen> createState() => _AddPreferencesScreenState();
}

class _AddPreferencesScreenState extends State<AddPreferencesScreen> {
  late PreferenceProvider _preferenceProvider;
  late GeneralUserProvider _generalUserProvider;
  late AuthProvider _authProvider;

  SearchResult<Preference>? preferences;
  bool isLoading = true;
  late UserData userData;

  @override
  void initState() {
    super.initState();
    _preferenceProvider = context.read<PreferenceProvider>();
    _generalUserProvider = context.read<GeneralUserProvider>();
    _authProvider = context.read<AuthProvider>();

    initScreen();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    userData = ModalRoute.of(context)?.settings.arguments as UserData;
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
      return const CircularProgressIndicator();
    }
  }

  dynamic _drawPreferenceCheckBoxGroup(List<Preference> preferences) {
    return FormBuilderCheckboxGroup(
      name: "preferences",
      onChanged: (value) => {
        userData.preferenceIds =
            value!.map((String value) => int.parse(value)).toList()
      },
      options: preferences
          .map((Preference preference) => FormBuilderFieldOption<String>(
                value: preference.preferenceId.toString(),
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
          var user = userData.user!;
          var requestObject = {
            "firstName": user.firstName,
            "lastName": user.lastName,
            "email": user.email,
            "username": user.username,
            "password": user.password,
            "gender": user.gender,
            "dateOfBirth": user.dateOfBirth?.toString(),
            "height": user.height,
            "weight": user.weight,
            "targetWeight": user.targetWeight,
            "activityLevelId": userData.activityLevelId,
            "goalId": userData.goalId
          };

          User newUser = await _generalUserProvider.insert(requestObject);

          Authorization.email = user.email;
          Authorization.password = user.password;
          Authorization.generalUserId = newUser.generalUserId;

          await _authProvider.login();
          await _generalUserProvider.addPreferences(
              newUser.generalUserId!, userData.preferenceIds!);

          Navigator.of(context).push(MaterialPageRoute(
              builder: ((context) => const HomeScreen()),
              settings: RouteSettings(arguments: userData)));
        },
        child: const Text("Finish registration"));
  }
}
