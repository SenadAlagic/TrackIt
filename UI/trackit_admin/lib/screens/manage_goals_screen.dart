import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/Goal/goal.dart';
import '../models/search_result.dart';
import '../providers/goal_provider.dart';
import '../utils/alert_helpers.dart';
import '../utils/image_helpers.dart';
import '../widgets/PaginationWidget/pagination_widget.dart';
import 'goal_details_screen.dart';
import 'master_screen.dart';

class ManageGoalsScreen extends StatefulWidget {
  const ManageGoalsScreen({super.key});

  @override
  State<ManageGoalsScreen> createState() => _ManageGoalsScreenState();
}

class _ManageGoalsScreenState extends State<ManageGoalsScreen> {
  final GlobalKey<PaginationWidgetState> _paginationKey =
      GlobalKey<PaginationWidgetState>();
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
    try {
      var result = await _goalProvider.get(filter: {'Page': 0, 'PageSize': 5});

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

  void onGoalAdded(Goal goal) {
    setState(() {
      goals!.result.add(goal);
      goals!.meta.count += 1;
    });
  }

  void onGoalUpdated(Goal updatedGoal) {
    var updatedGoals = goals;
    var indexOf = updatedGoals!.result
        .indexWhere((Goal goal) => goal.goalId == updatedGoal.goalId);
    updatedGoals.result[indexOf] = updatedGoal;
    setState(() {
      goals = updatedGoals;
    });
  }

  void onResultFetched(SearchResult<dynamic> result) {
    setState(() {
      goals = result as SearchResult<Goal>;
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
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: [
          SingleChildScrollView(
              child: IntrinsicHeight(
                  child: Column(
            children: goals!.result.map((goal) => _drawGoalCard(goal)).toList(),
          ))),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: () => {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          GoalDetailsScreen(onItemAdded: onGoalAdded)))
                },
                child: const Card(
                  child: Padding(
                      padding: EdgeInsets.all(4),
                      child: Text("Add a new goal")),
                ),
              )
            ],
          ),
          PaginationWidget(
              key: _paginationKey, goals!, _goalProvider, onResultFetched, 5)
        ]));
  }

  Widget _drawGoalCard(Goal goal) {
    return Card(
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
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(goal.description ?? "")
          ],
        )),
        InkWell(
            onTap: () => {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => GoalDetailsScreen(
                          goal: goal, onItemUpdated: onGoalUpdated)))
                },
            child: const Icon(Icons.create_outlined)),
        InkWell(
            onTap: () {
              _goalProvider.delete(goal.goalId!);
              setState(() {
                goals!.result.remove(goal);
                goals!.meta.count -= 1;
              });
              if (goals!.result.isEmpty) {
                _paginationKey.currentState?.handleGoBack();
              }
            },
            child: const Icon(Icons.delete_outline)),
        const SizedBox(
          width: 16,
        )
      ]),
    );
  }
}
