import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'manage_activity_levels_screen.dart';
import 'manage_goals_screen.dart';
import 'manage_ingredients_screen.dart';
import 'manage_meals_screen.dart';
import 'manage_tags_screen.dart';
import 'master_screen.dart';
import 'reports_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
        title: "Home screen",
        child: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          _buildTitle(),
          _buildFirstRow(context),
          _buildSecondRow(context),
        ])));
  }

  Padding _buildTitle() {
    return const Padding(
        padding: EdgeInsets.only(bottom: 32),
        child: Text(
          "Welcome!",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
        ));
  }

  Row _buildSecondRow(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      _buildContainer('assets/svg/mealsIcon.svg', "Manage meals",
          const ManageMealsScreen(), context),
      const SizedBox(width: 10),
      _buildContainer('assets/svg/tagsIcon.svg', "Manage tags",
          const ManageTagsScreen(), context),
      const SizedBox(width: 10),
      _buildContainer("assets/svg/reportsIcon.svg", "View reports",
          const ReportsScreen(), context)
    ]);
  }

  Row _buildFirstRow(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      _buildContainer('assets/svg/goalsIcon.svg', "Manage goals",
          const ManageGoalsScreen(), context),
      const SizedBox(width: 10),
      _buildContainer('assets/svg/ingredientsIcon.svg', "Manage ingredients",
          const ManageIngredientsScreen(), context),
      const SizedBox(width: 10),
      _buildContainer('assets/svg/activityLevelsIcon.svg', "Activity levels",
          const ManageActivityLevelsScreen(), context)
    ]);
  }

  InkWell _buildContainer(
      String iconPath, String title, Widget screen, BuildContext context) {
    var icon = SvgPicture.asset(
      iconPath,
      height: 120,
      width: 120,
    );
    return InkWell(
        onTap: () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => screen)),
        child: Card(
          child: Container(
              height: 200,
              width: 200,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20.0),
                      ),
                      icon
                    ],
                  ))),
        ));
  }
}
