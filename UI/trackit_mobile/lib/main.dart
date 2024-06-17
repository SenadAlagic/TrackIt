import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/activity_level_provider.dart';
import 'providers/auth_provider.dart';
import 'providers/daily_intake_provider.dart';
import 'providers/general_user_provider.dart';
import 'providers/goal_provider.dart';
import 'providers/preference_provider.dart';
import 'providers/user_meals_provider.dart';
import 'providers/user_provider.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => AuthProvider()),
    ChangeNotifierProvider(create: (_) => GoalProvider()),
    ChangeNotifierProvider(create: (_) => ActivityLevelProvider()),
    ChangeNotifierProvider(create: (_) => PreferenceProvider()),
    ChangeNotifierProvider(create: (_) => GeneralUserProvider()),
    ChangeNotifierProvider(create: (_) => UserMealsProvider()),
    ChangeNotifierProvider(create: (_) => UserProvider()),
    ChangeNotifierProvider(create: (_) => DailyIntakeProvider()),
  ], child: const HomePage()));
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
