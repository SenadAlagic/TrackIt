import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/DailyIntake/daily_intake.dart';
import '../providers/daily_intake_provider.dart';
import '../utils/alert_helpers.dart';
import '../utils/authorization.dart';
import '../utils/user_info.dart';
import 'master_screen.dart';

class DailyIntakeScreen extends StatefulWidget {
  const DailyIntakeScreen({super.key});

  @override
  State<DailyIntakeScreen> createState() => _DailyIntakeScreenState();
}

class _DailyIntakeScreenState extends State<DailyIntakeScreen> {
  late DailyIntakeProvider _dailyIntakeProvider;
  DailyIntake? dailyCalorieIntake;

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _dailyIntakeProvider = context.read<DailyIntakeProvider>();
    initScreen();
  }

  Future initScreen() async {
    try {
      var dailyIntakeResult = await _dailyIntakeProvider
          .get(filter: {"UserId": Authorization.generalUserId});

      setState(() {
        if (dailyIntakeResult.result.isNotEmpty) {
          dailyCalorieIntake = dailyIntakeResult.result[0];
        }
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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(children: [
        const Text(
          "Today's intake",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        const Divider(
          thickness: 1,
          color: Colors.black,
        ),
        _drawCalorieProgressIndicator(),
        const Divider(
          thickness: 1,
          color: Colors.black,
        ),
        _drawProgressIndicator(
            dailyCalorieIntake?.protein ?? 0,
            0.5 * UserInfo.weight * UserInfo.user!.activityLevel!.multiplier!,
            "Protein"),
        _drawProgressIndicator(dailyCalorieIntake?.carbs ?? 0,
            200 * UserInfo.user!.activityLevel!.multiplier!, "Carbs"),
        _drawProgressIndicator(dailyCalorieIntake?.fat ?? 0,
            100 * UserInfo.user!.activityLevel!.multiplier!, "Fat"),
      ]),
    );
  }

  Widget _drawProgressIndicator(double completed, double needed, String hint) {
    return Padding(
        padding: const EdgeInsets.all(8),
        child: Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: Column(
              children: [
                Padding(
                    padding: const EdgeInsets.only(top: 4, bottom: 4, left: 16),
                    child: Align(
                        alignment: Alignment.centerLeft, child: Text(hint))),
                Padding(
                    padding:
                        const EdgeInsets.only(left: 16, right: 16, bottom: 4),
                    child: LinearProgressIndicator(
                      backgroundColor: Colors.black,
                      color: Colors.yellow,
                      value: completed / (needed * 1.0),
                      minHeight: 10,
                      borderRadius: BorderRadius.circular(20),
                    )),
                Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                        padding: const EdgeInsets.only(right: 16, bottom: 8),
                        child: Text("$completed/$needed g")))
              ],
            )));
  }

  Widget _drawCalorieProgressIndicator() {
    var dailyCaloriesNeeded =
        UserInfo.bmr! * UserInfo.user!.activityLevel!.multiplier!;
    double percentageCompleted = 0;
    if (dailyCalorieIntake?.calories != null) {
      percentageCompleted = dailyCalorieIntake!.calories! / dailyCaloriesNeeded;
    }
    return Column(children: [
      const Align(
          alignment: Alignment.centerLeft,
          child:
              Text("Calories", style: TextStyle(fontWeight: FontWeight.bold))),
      Padding(
        padding: const EdgeInsets.all(18.0),
        child: CircularProgressIndicator(
          strokeAlign: 2,
          strokeWidth: 10,
          value: percentageCompleted,
          color: Colors.black,
          backgroundColor: Colors.white,
        ),
      ),
      Text("${dailyCalorieIntake?.calories ?? 0}/$dailyCaloriesNeeded kcal",
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold))
    ]);
  }
}
