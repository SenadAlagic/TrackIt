import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import '../utils/authorization.dart';
import 'home_screen.dart';
import 'master_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  late AuthProvider _authProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _authProvider = context.read<AuthProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
        child: Center(
            child: Container(
      constraints: const BoxConstraints(maxWidth: 400, maxHeight: 400),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Image.asset(
                "assets/images/trackItLogo.png",
                height: 200,
                width: 200,
              ),
              TextField(
                decoration: const InputDecoration(
                    labelText: "E-mail", prefixIcon: Icon(Icons.email)),
                controller: _emailController,
              ),
              const SizedBox(height: 8),
              TextField(
                obscureText: true,
                decoration: const InputDecoration(
                    labelText: "Password", prefixIcon: Icon(Icons.password)),
                controller: _passwordController,
              ),
              const SizedBox(
                height: 8,
              ),
              ElevatedButton(
                  onPressed: () async {
                    Authorization.email = _emailController.text;
                    Authorization.password = _passwordController.text;
                    // Authorization.email = "adminovic@admin.com";
                    // Authorization.password = "admin123";

                    var loginResponse = await _authProvider.login();
                    if (loginResponse.result == 0) {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const HomeScreen()));
                    } else {
                      if (context.mounted) {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  title: const Text("Invalid login"),
                                  content:
                                      const Text("Invalid login credentials."),
                                  actions: [
                                    TextButton(
                                        onPressed: () =>
                                            {Navigator.pop(context)},
                                        child: const Text("OK"))
                                  ],
                                ));
                      }
                    }
                  },
                  child: const Text("Login"))
            ],
          ),
        ),
      ),
    )));
  }
}
