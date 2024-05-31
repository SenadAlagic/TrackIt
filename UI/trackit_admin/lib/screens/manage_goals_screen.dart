import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trackit_admin/screens/goal_details_screen.dart';

import '../models/Goal/goal.dart';
import '../models/search_result.dart';
import '../providers/goal_provider.dart';
import 'master_screen.dart';

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
    var result = await _goalProvider.get();

    setState(() {
      goals = result;
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
                  onTap: () => {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const GoalDetailsScreen()))
                  },
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
                : Image.asset("assets/images/NoImageFound.jpg",
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
        InkWell(
            onTap: () => {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => GoalDetailsScreen(goal: goal)))
                },
            child: const Icon(Icons.create_outlined)),
        InkWell(
            onTap: () {
              _goalProvider.delete(goal.goalId!);
              setState(() {
                goals!.result.remove(goal);
                goals!.count -= 1;
              });
            },
            child: const Icon(Icons.delete_outline)),
        const SizedBox(
          width: 16,
        )
      ]),
    );
  }
}
