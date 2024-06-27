import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import 'daily_intake_screen.dart';
import 'home_screen.dart';
import 'log_meal.dart';
import 'meal_search.dart';
import 'meals_list_screen.dart';
import 'profile_screen.dart';
import 'recommend_meal_screen.dart';
import 'settings_screen.dart';
import 'upgrade_account_screen.dart';

class MasterScreen extends StatefulWidget {
  final Widget? child;
  final String? title;
  const MasterScreen({super.key, this.title, this.child});

  @override
  State<MasterScreen> createState() => _MasterScreenState();
}

class _MasterScreenState extends State<MasterScreen> {
  late AuthProvider _authProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _authProvider = context.read<AuthProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title ?? ""),
          leading: Navigator.canPop(context)
              ? IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.arrow_back))
              : null,
          actions: [
            Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: _drawProfileIcon())
          ],
        ),
        drawer: Drawer(
          child: ListView(children: [
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text("Home"),
              onTap: () => {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                    ModalRoute.withName("HomeScreen"))
              },
            ),
            ListTile(
              leading: const Icon(Icons.restaurant),
              title: const Text("Meals list"),
              onTap: () => {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) => const MealsListScreen()),
                    ModalRoute.withName("MealsListScreen"))
              },
            ),
            ListTile(
              leading: const Icon(Icons.add),
              title: const Text("Log a meal"),
              onTap: () => {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) => const LogMealScreen()),
                    ModalRoute.withName("LogMealScreen"))
              },
            ),
            ListTile(
              leading: const Icon(Icons.search),
              title: const Text("Search for a meal"),
              onTap: () => {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) => const MealSearchScreen()),
                    ModalRoute.withName("MealSearchScreen"))
              },
            ),
            ListTile(
              leading: const Icon(Icons.recommend),
              title: const Text("Recommend a meal"),
              trailing: SvgPicture.asset("assets/svg/premium.svg"),
              onTap: () => {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) => const RecommendMealScreen()),
                    ModalRoute.withName("RecommendMealScreen"))
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout_rounded),
              title: const Text("Logout"),
              onTap: () => {_authProvider.logout(context)},
            )
          ]),
        ),
        body: SafeArea(child: SingleChildScrollView(child: widget.child!)));
  }

  Widget _drawProfileIcon() {
    return PopupMenuButton(
        icon: const Icon(
          Icons.account_circle_outlined,
          size: 32,
        ),
        itemBuilder: (BuildContext context) => <PopupMenuEntry>[
              PopupMenuItem(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: ((context) => const ProfileScreen())));
                },
                child: const ListTile(
                  title: Text("Profile"),
                  leading: Icon(Icons.account_circle_outlined),
                ),
              ),
              PopupMenuItem(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: ((context) => const DailyIntakeScreen())));
                },
                child: const ListTile(
                  title: Text("Daily intake"),
                  leading: Icon(Icons.calendar_today),
                ),
              ),
              PopupMenuItem(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: ((context) => const UpgradeAccountScreen())));
                },
                child: const ListTile(
                  title: Text("Upgrade account"),
                  leading: Icon(Icons.upgrade),
                ),
              ),
              PopupMenuItem(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: ((context) => const SettingsScreen())));
                },
                child: const ListTile(
                  title: Text("Settings"),
                  leading: Icon(Icons.settings),
                ),
              ),
              PopupMenuItem(
                onTap: () {
                  _authProvider.logout(context);
                },
                child: const ListTile(
                  title: Text("Logout"),
                  leading: Icon(Icons.logout_rounded),
                ),
              )
            ]);
  }
}
