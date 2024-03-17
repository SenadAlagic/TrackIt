import 'package:flutter/material.dart';
import 'package:trackit_admin/screens/master_screen.dart';

class ManageMealsScreen extends StatelessWidget {
  const ManageMealsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      title: "Manage meals",
      child: const Text("Manage Meals"),
    );
  }
}
