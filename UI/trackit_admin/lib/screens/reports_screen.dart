import 'package:flutter/material.dart';
import 'package:trackit_admin/screens/master_screen.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      title: "Reports",
      child: const Placeholder(),
    );
  }
}
