import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import 'home_screen.dart';
import 'meals_list_screen.dart';
import 'settings_screen.dart';

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
                        builder: (context) => const MealsListScren()),
                    ModalRoute.withName("HomeScreen"))
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
