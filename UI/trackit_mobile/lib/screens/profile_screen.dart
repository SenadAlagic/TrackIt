import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../utils/user_info.dart';
import 'master_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return MasterScreen(child: _buildScreen());
  }

  Widget _buildScreen() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(children: [
            const Icon(
              Icons.person,
              size: 80,
            ),
            Text(
                "${UserInfo.user!.user!.firstName} ${UserInfo.user!.user!.lastName}",
                style: const TextStyle(fontSize: 25)),
            UserInfo.user!.isUserPremium!
                ? SvgPicture.asset("assets/svg/premium.svg")
                : Container(),
          ]),
          const Divider(
            thickness: 1,
            color: Colors.black,
          ),
          _drawCalorieProgressIndicator(),
          const Divider(
            thickness: 1,
            color: Colors.black,
          ),
          _drawGoalDetails(),
        ],
      ),
    );
  }

  Widget _drawCalorieProgressIndicator() {
    var user = UserInfo.user!;
    var lastLoggedWeight = UserInfo.lastLoggedWeight;
    var weightDiff = lastLoggedWeight == null
        ? user.weight! - user.targetWeight!
        : lastLoggedWeight - user.targetWeight!;

    var toDisplay = weightDiff > 0
        ? "${weightDiff.abs()}kg gained"
        : "${weightDiff.abs()}kg lost";

    return Column(children: [
      const Align(
          alignment: Alignment.centerLeft,
          child:
              Text("Progress", style: TextStyle(fontWeight: FontWeight.bold))),
      SvgPicture.asset("assets/svg/gaugeIcon.svg", height: 70, width: 100),
      Text(toDisplay,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold))
    ]);
  }

  Widget _drawGoalDetails() {
    return Column(children: [
      const Align(
          alignment: Alignment.centerLeft,
          child: Text("Goal", style: TextStyle(fontWeight: FontWeight.bold))),
      Text("Weight: ${UserInfo.weight}kg",
          style: const TextStyle(fontSize: 18)),
      Text(UserInfo.user?.goal?.name ?? "",
          style: const TextStyle(fontSize: 18))
    ]);
  }
}
