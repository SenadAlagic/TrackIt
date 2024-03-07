import 'package:flutter/material.dart';
import 'package:trackit_admin/screens/home_screen.dart';
import 'package:trackit_admin/screens/master_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

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
                  onPressed: () {
                    var email = _emailController.text;
                    var password = _passwordController.text;
                    print("$email $password");

                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const HomeScreen()));
                  },
                  child: const Text("Login"))
            ],
          ),
        ),
      ),
    )));
  }
}
