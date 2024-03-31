import 'package:flutter/material.dart';

import 'master_screen.dart';

class ManageIngredientsScreen extends StatelessWidget {
  const ManageIngredientsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      title: "Manage ingredients",
      child: const Text("Manage ingredients"),
    );
  }
}
