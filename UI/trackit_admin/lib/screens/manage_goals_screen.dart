import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trackit_admin/models/Goal/goal.dart';
import 'package:trackit_admin/models/search_result.dart';
import 'package:trackit_admin/providers/goal_provider.dart';
import 'package:trackit_admin/screens/master_screen.dart';

class ManageGoalsScreen extends StatefulWidget {
  const ManageGoalsScreen({super.key});

  @override
  State<ManageGoalsScreen> createState() => _ManageGoalsScreenState();
}

class _ManageGoalsScreenState extends State<ManageGoalsScreen> {
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
    goals = await _goalProvider.get();

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      title: "Manage goals",
      child: isLoading ? Container() : _buildScreen(),
    );
  }

  Widget _buildScreen() {
    if (goals?.result.isNotEmpty ?? false) {
      return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(children: [
            SingleChildScrollView(
                child: IntrinsicHeight(
                    child: Column(
              children:
                  goals!.result.map((goal) => _drawGoalCard(goal)).toList(),
            ))),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () => {},
                  child: const Card(
                    child: Padding(
                        padding: EdgeInsets.all(4),
                        child: Text("Add a new goal")),
                  ),
                )
              ],
            )
          ]));
    } else {
      return const CircularProgressIndicator();
    }
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
                : Image.asset("assets/images/NoImageFound.png",
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
        InkWell(onTap: () => {}, child: const Icon(Icons.create_outlined)),
        InkWell(onTap: () => {}, child: const Icon(Icons.delete_outline)),
        const SizedBox(
          width: 16,
        )
      ]),
    );
  }
}
