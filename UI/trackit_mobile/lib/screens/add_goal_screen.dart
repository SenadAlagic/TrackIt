import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/Goal/goal.dart';
import '../models/UserData/user_data.dart';
import '../models/search_result.dart';
import '../providers/general_user_provider.dart';
import '../providers/goal_provider.dart';
import '../utils/alert_helpers.dart';
import '../utils/form_helpers.dart';
import '../utils/image_helpers.dart';
import '../utils/user_info.dart';
import 'add_activity_level_screen.dart';
import 'master_screen.dart';

class AddGoalScreen extends StatefulWidget {
  final bool? isEdit;
  const AddGoalScreen({super.key, this.isEdit});

  @override
  State<AddGoalScreen> createState() => _AddGoalScreenState();
}

class _AddGoalScreenState extends State<AddGoalScreen> {
  late GoalProvider _goalProvider;
  late GeneralUserProvider _generalUserProvider;
  SearchResult<Goal>? goals;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _goalProvider = context.read<GoalProvider>();
    _generalUserProvider = context.read<GeneralUserProvider>();
    initScreen();
  }

  Future initScreen() async {
    try {
      var result = await _goalProvider.get();

      setState(() {
        goals = result;
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
    if (goals?.result.isNotEmpty ?? false) {
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
                    "Select your goal",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                ...goals!.result.map((goal) => _drawGoalCard(goal)).toList()
              ],
            ))),
          ]));
    } else {
      return FormHelpers.drawProgressIndicator();
    }
  }

  Widget _drawGoalCard(Goal goal) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: ElevatedButton(
          style: const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Colors.white)),
          onPressed: () async {
            if (widget.isEdit ?? false) {
              await _generalUserProvider.selectGoal(
                  UserInfo.user!.generalUserId!, goal.goalId!);
              Navigator.of(context).pop();
            } else {
              var userData =
                  ModalRoute.of(context)?.settings.arguments as UserData;
              userData.goalId = goal.goalId;
              Navigator.of(context).push(MaterialPageRoute(
                  builder: ((context) => const AddActivityLevelScreen()),
                  settings: RouteSettings(arguments: userData)));
            }
          },
          child: Row(children: [
            const SizedBox(
              height: 80,
            ),
            Padding(
                padding: const EdgeInsets.only(left: 16, right: 16.0),
                child: ImageHelpers.getImage(goal.image)),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  goal.name ?? "",
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  goal.description ?? "",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                )
              ],
            )),
          ]),
        ));
  }
}
