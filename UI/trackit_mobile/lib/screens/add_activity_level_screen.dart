import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/ActivityLevel/activity_level.dart';
import '../models/UserData/user_data.dart';
import '../models/search_result.dart';
import '../providers/activity_level_provider.dart';
import '../providers/general_user_provider.dart';
import '../utils/alert_helpers.dart';
import '../utils/form_helpers.dart';
import '../utils/image_helpers.dart';
import '../utils/user_info.dart';
import 'add_preferences_screen.dart';
import 'master_screen.dart';

class AddActivityLevelScreen extends StatefulWidget {
  final bool? isEdit;
  const AddActivityLevelScreen({super.key, this.isEdit});

  @override
  State<AddActivityLevelScreen> createState() => _AddActivityLevelScreenState();
}

class _AddActivityLevelScreenState extends State<AddActivityLevelScreen> {
  late ActivityLevelProvider _activityLevelProvider;
  late GeneralUserProvider _generalUserProvider;
  SearchResult<ActivityLevel>? activityLevels;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _activityLevelProvider = context.read<ActivityLevelProvider>();
    _generalUserProvider = context.read<GeneralUserProvider>();
    initScreen();
  }

  Future initScreen() async {
    try {
      var result = await _activityLevelProvider.get();
      setState(() {
        activityLevels = result;
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
    return MasterScreen(child: _buildScreen());
  }

  Widget _buildScreen() {
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
      return FormHelpers.drawProgressIndicator();
    }
  }

  Widget _drawActivityLevelCard(ActivityLevel activityLevel) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: ElevatedButton(
          style: const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Colors.white)),
          onPressed: () async {
            if (widget.isEdit ?? false) {
              await _generalUserProvider.selectActivityLevel(
                  UserInfo.user!.generalUserId!,
                  activityLevel.activityLevelId!);
              Navigator.of(context).pop();
            } else {
              var userData =
                  ModalRoute.of(context)?.settings.arguments as UserData;
              userData.activityLevelId = activityLevel.activityLevelId;
              Navigator.of(context).push(MaterialPageRoute(
                  builder: ((context) => const AddPreferencesScreen()),
                  settings: RouteSettings(arguments: userData)));
            }
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
