import 'package:flutter/material.dart';

import 'master_screen.dart';

class ManageTagsScreen extends StatelessWidget {
  const ManageTagsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      title: "Manage tags",
      child: const Text("Manage tags"),
    );
  }
}