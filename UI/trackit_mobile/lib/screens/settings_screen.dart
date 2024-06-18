import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import '../providers/user_provider.dart';
import '../utils/user_info.dart';
import 'add_activity_level_screen.dart';
import 'add_goal_screen.dart';
import 'edit_preferences_screen.dart';
import 'edit_user_screen.dart';
import 'login_screen.dart';
import 'master_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late AuthProvider _authProvider;
  late UserProvider _userProvider;

  @override
  void initState() {
    _authProvider = context.read<AuthProvider>();
    _userProvider = context.read<UserProvider>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
        child: SingleChildScrollView(
      child: _drawScreen(context),
    ));
  }

  Widget _drawScreen(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 32),
                  child: Text(
                    "Settings",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                ),
                _drawSettingsOption("Edit goals",
                    route: const AddGoalScreen(isEdit: true), context: context),
                _drawSettingsOption("Edit preferences",
                    route: const EditPreferencesScreen(), context: context),
                _drawSettingsOption("Edit activity level",
                    route: const AddActivityLevelScreen(isEdit: true),
                    context: context),
                _drawSettingsOption("Edit your user info",
                    route: const EditUserScreen(), context: context),
                const SizedBox(height: 20),
                _drawSettingsOption(
                  "Sign out",
                  onTap: () => {_authProvider.logout(context)},
                ),
                _drawSettingsOption(
                  "Delete my account",
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: ((context) => AlertDialog(
                              title: const Text("Caution"),
                              content: const Text(
                                  "Are you sure you want to delete your account?"),
                              actions: [
                                TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text("Cancel",
                                        style: TextStyle(color: Colors.black))),
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      _userProvider
                                          .delete(UserInfo.user!.userId!);
                                      Navigator.of(context).pushAndRemoveUntil(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const LoginScreen()),
                                          ModalRoute.withName("LoginScreen"));
                                    },
                                    child: const Text("Continue",
                                        style: TextStyle(color: Colors.black)))
                              ],
                            )));
                  },
                ),
              ],
            ))
      ],
    );
  }

  Widget _drawSettingsOption(String text,
      {void Function()? onTap, Widget? route, BuildContext? context}) {
    return Padding(
        padding: const EdgeInsets.all(2),
        child: InkWell(
            onTap: route != null
                ? () => Navigator.of(context!)
                    .push(MaterialPageRoute(builder: ((context) => route)))
                : onTap,
            child: Text(
              text,
              style: const TextStyle(fontSize: 16),
            )));
  }
}
