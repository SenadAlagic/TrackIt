import 'package:flutter/material.dart';
import '../screens/login_screen.dart';

void main() {
  runApp(const HomePage());
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "TrackIt",
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(
              primarySwatch: Colors.yellow, brightness: Brightness.light),
          fontFamily: "Calibri",
          useMaterial3: false,
        ),
        home: LoginScreen());
  }
}
