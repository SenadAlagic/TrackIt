import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trackit_mobile/models/ActivityLevel/activity_level.dart';
import 'package:trackit_mobile/models/search_result.dart';
import 'package:trackit_mobile/providers/activity_level_provider.dart';
import 'package:trackit_mobile/screens/add_preferences_screen.dart';

import '../models/UserData/user_data.dart';
import '../utils/image_helpers.dart';

class AddActivityLevelScreen extends StatefulWidget {
  const AddActivityLevelScreen({super.key});

  @override
  State<AddActivityLevelScreen> createState() => _AddActivityLevelScreenState();
}

class _AddActivityLevelScreenState extends State<AddActivityLevelScreen> {
  late ActivityLevelProvider _activityLevelProvider;
  SearchResult<ActivityLevel>? activityLevels;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _activityLevelProvider = context.read<ActivityLevelProvider>();
    initScreen();
  }

  Future initScreen() async {
    var result = await _activityLevelProvider.get();
    setState(() {
      activityLevels = result;
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
    if (activityLevels?.result.isNotEmpty ?? false) {
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
                    "Select your activity level",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                ...activityLevels!.result
                    .map((activityLevel) =>
                        _drawActivityLevelCard(activityLevel))
                    .toList()
              ],
            ))),
          ]));
    } else {
      return const CircularProgressIndicator();
    }
  }

  Widget _drawActivityLevelCard(ActivityLevel activityLevel) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: ElevatedButton(
          style: const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Colors.white)),
          onPressed: () {
            var userData =
                ModalRoute.of(context)?.settings.arguments as UserData;
            userData.activityLevelId = activityLevel.activityLevelId;
            Navigator.of(context).push(MaterialPageRoute(
                builder: ((context) => const AddPreferencesScreen()),
                settings: RouteSettings(arguments: userData)));
          },
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
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text("${activityLevel.multiplier}x")
              ],
            )),
          ]),
        ));
  }
}
