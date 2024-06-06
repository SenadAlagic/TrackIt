import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trackit_mobile/providers/auth_provider.dart';

import 'screens/login_screen.dart';

void main() {
  runApp(MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => AuthProvider())],
      child: const HomePage()));
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