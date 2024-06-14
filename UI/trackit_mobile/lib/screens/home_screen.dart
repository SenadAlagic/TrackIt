import 'package:flutter/material.dart';

import 'master_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return MasterScreen(child: _drawScreen());
  }

  Widget _drawScreen() {
    return Container(
        decoration: const BoxDecoration(color: Colors.yellow),
        child: const Center(
          child: Column(
            children: [
              Text(
                "Welcome",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ));
  }
}
