import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import '../utils/alert_helpers.dart';
import '../utils/authorization.dart';
import 'home_screen.dart';
import 'master_screen.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  Map<String, dynamic> _initialValue = {};

  late AuthProvider _authProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _authProvider = context.read<AuthProvider>();
  }

  @override
  void initState() {
    _initialValue = {"email": "", "password": ""};
    super.initState();
  }

  Widget _drawSubmitButton() {
    return ElevatedButton(
        onPressed: () async {
          _formKey.currentState?.saveAndValidate();
          if (!_formKey.currentState!.isValid) return;
          var formInfo = Map.from(_formKey.currentState!.value);

          Authorization.email = formInfo["email"];
          Authorization.password = formInfo["password"];
          try {
            var loginResponse = await _authProvider.login();
            if (loginResponse.result == 0) {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const HomeScreen()));
            } else {
              if (context.mounted) {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: const Text("Invalid login"),
                          content: const Text("Invalid login credentials."),
                          actions: [
                            TextButton(
                                onPressed: () => {Navigator.pop(context)},
                                child: const Text("OK"))
                          ],
                        ));
              }
            }
          } on Exception catch (e) {
            if (context.mounted) {
              AlertHelpers.showAlert(context, "Error", e.toString());
            }
          }
        },
        child: const Text("Login"));
  }

  Widget _drawRegisterButton() {
    return ElevatedButton(
        style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(Colors.grey[850])),
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (builder) => const RegisterScreen()));
        },
        child: const Text(
          "Register",
          style: TextStyle(color: Colors.yellow),
        ));
  }

  List<Widget> _drawForm() {
    return [
      FormBuilderTextField(
        name: "email",
        validator: FormBuilderValidators.compose(
            [FormBuilderValidators.required(), FormBuilderValidators.email()]),
        decoration: const InputDecoration(
            labelText: "E-mail", prefixIcon: Icon(Icons.email)),
        controller: _emailController,
      ),
      const SizedBox(height: 8),
      FormBuilderTextField(
        name: "password",
        validator:
            FormBuilderValidators.compose([FormBuilderValidators.required()]),
        obscureText: true,
        decoration: const InputDecoration(
            labelText: "Password", prefixIcon: Icon(Icons.password)),
        controller: _passwordController,
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
        hideAppBar: true,
        child: Center(
            child: Container(
          constraints: const BoxConstraints(maxWidth: 400, maxHeight: 450),
          child: Card(
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: FormBuilder(
                  key: _formKey,
                  initialValue: _initialValue,
                  child: Column(
                    children: [
                      Image.asset(
                        "assets/images/trackItLogo.png",
                        height: 200,
                        width: 200,
                      ),
                      ..._drawForm(),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _drawSubmitButton(),
                          const SizedBox(width: 30),
                          _drawRegisterButton()
                        ],
                      )
                    ],
                  ),
                )),
          ),
        )));
  }
}
