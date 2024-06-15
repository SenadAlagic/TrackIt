import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trackit_mobile/models/UserData/user_data.dart';
import 'package:trackit_mobile/screens/add_activity_level_screen.dart';
import 'package:trackit_mobile/utils/form_helpers.dart';
import 'package:trackit_mobile/utils/image_helpers.dart';

import '../models/Goal/goal.dart';
import '../models/search_result.dart';
import '../providers/goal_provider.dart';

class AddGoalScreen extends StatefulWidget {
  const AddGoalScreen({super.key});

  @override
  State<AddGoalScreen> createState() => _AddGoalScreenState();
}

class _AddGoalScreenState extends State<AddGoalScreen> {
  late GoalProvider _goalProvider;
  SearchResult<Goal>? goals;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _goalProvider = context.read<GoalProvider>();
    initScreen();
  }

  Future initScreen() async {
    var result = await _goalProvider.get();

    setState(() {
      goals = result;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
          child: SingleChildScrollView(
        child: _drawScreen(),
      )),
    );
  }

  Widget _drawScreen() {
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
          onPressed: () {
            var userData =
                ModalRoute.of(context)?.settings.arguments as UserData;
            userData.goalId = goal.goalId;
            Navigator.of(context).push(MaterialPageRoute(
                builder: ((context) => const AddActivityLevelScreen()),
                settings: RouteSettings(arguments: userData)));
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
