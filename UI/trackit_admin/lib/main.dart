import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screens/login_screen.dart';
import 'providers/activity_level_provider.dart';
import 'providers/auth_provider.dart';
import 'providers/goal_provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => GoalProvider()),
      ChangeNotifierProvider(create: (_) => ActivityLevelProvider()),
      ChangeNotifierProvider(create: (_) => AuthProvider()),
    ],
    child: const HomePage(),
  ));
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "TrackIt",
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.yellow,
          colorScheme: ColorScheme.fromSwatch(
              primarySwatch: Colors.yellow, brightness: Brightness.light),
          fontFamily: "Calibri",
          useMaterial3: false,
        ),
        home: const LoginScreen());
  }
}
