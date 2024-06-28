import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';

import '../models/Admin/admin.dart';
import '../providers/admin_provider.dart';
import '../utils/alert_helpers.dart';
import '../utils/form_helpers.dart';
import 'login_screen.dart';
import 'master_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late AdminProvider _adminProvider;
  final _formKey = GlobalKey<FormBuilderState>();
  Map<String, dynamic> _initialValue = {};

  @override
  void initState() {
    super.initState();
    _initialValue = {
      "firstName": "",
      "lastName": "",
      "email": "",
      "username": "",
      "password": "",
    };
    _adminProvider = context.read<AdminProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(child: _buildScreen());
  }

  Widget _buildScreen() {
    return Container(
        decoration: const BoxDecoration(color: Colors.yellow),
        child: FormBuilder(
            key: _formKey,
            initialValue: _initialValue,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 20, bottom: 20),
                      child: Text(
                        "Your basic info",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    FormHelpers.drawStringContainer("First name", "firstName",
                        customValidators: [
                          FormBuilderValidators.minLength(3),
                        ]),
                    FormHelpers.drawStringContainer("Last name", "lastName",
                        customValidators: [FormBuilderValidators.minLength(3)]),
                    FormHelpers.drawStringContainer("Email", "email",
                        customValidators: [
                          FormBuilderValidators.email(
                              errorText: "Field must be a valid email")
                        ]),
                    FormHelpers.drawStringContainer("Username", "username",
                        customValidators: [FormBuilderValidators.minLength(5)]),
                    FormHelpers.drawStringContainer("Password", "password",
                        obscureText: true,
                        customValidators: [
                          FormBuilderValidators.minLength(6),
                        ]),
                    FormHelpers.drawStringContainer(
                        "Confirm password", "passwordConfirm",
                        obscureText: true,
                        customValidators: [
                          FormBuilderValidators.minLength(6),
                        ]),
                    _drawSubmitButton()
                  ],
                )
              ],
            )));
  }

  Widget _drawSubmitButton() {
    return ElevatedButton(
        style: const ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(Colors.white)),
        onPressed: () async {
          _formKey.currentState?.saveAndValidate();
          if (!_formKey.currentState!.isValid) return;
          Map<String, dynamic> request = Map.from(_formKey.currentState!.value);

          if (request['password'] != request['passwordConfirm']) {
            _formKey.currentState!.fields['passwordConfirm']
                ?.invalidate("Passwords must match");
          }

          try {
            var adminRequest = Admin.fromInitialValues(request);
            await _adminProvider.insert(adminRequest);
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const LoginScreen()),
              ModalRoute.withName('LoginScreen'),
            );
          } on Exception catch (e) {
            if (context.mounted) {
              AlertHelpers.showAlert(context, "Error", e.toString());
            }
          }
        },
        child: const Text("Submit"));
  }
}
