import 'package:flutter/material.dart';

import 'master_screen.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  @override
  Widget build(BuildContext context) {
    return const MasterScreen(
      title: "Reports",
      child: Placeholder(),
    );
  }
}
