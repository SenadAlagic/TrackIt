import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import '../providers/general_user_provider.dart';
import '../utils/alert_helpers.dart';
import '../utils/authorization.dart';
import '../utils/user_info.dart';
import 'home_screen.dart';
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
  late GeneralUserProvider _generalUserProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _authProvider = context.read<AuthProvider>();
    _generalUserProvider = context.read<GeneralUserProvider>();
  }

  @override
  void initState() {
    _initialValue = {"email": "", "password": ""};
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(
      children: [
        Container(
          decoration: const BoxDecoration(color: Colors.yellow),
        ),
        Container(
            margin: const EdgeInsets.only(top: 100),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Image.asset("assets/images/trackItLogo.png",
                height: 100, width: 200)),
        Padding(
          padding:
              const EdgeInsets.only(top: 40, left: 40, right: 40, bottom: 10),
          child: Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: FormBuilder(
                key: _formKey,
                initialValue: _initialValue,
                child: Column(children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                        border: Border(bottom: BorderSide(color: Colors.grey))),
                    child: FormBuilderTextField(
                      name: "email",
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                        FormBuilderValidators.email()
                      ]),
                      controller: _emailController,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "E-mail",
                          hintStyle: TextStyle(color: Colors.grey[400])),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    child: FormBuilderTextField(
                      name: "password",
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                      ]),
                      obscureText: true,
                      controller: _passwordController,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Password",
                          hintStyle: TextStyle(color: Colors.grey[400])),
                    ),
                  ),
                ]),
              )),
        ),
        Padding(
            padding: const EdgeInsets.only(bottom: 40, right: 40),
            child: Container(
              alignment: Alignment.centerRight,
              child: InkWell(
                  onTap: () => {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: ((context) => const RegisterScreen())))
                      },
                  child: const Text(
                    "Create an account",
                    style: TextStyle(decoration: TextDecoration.underline),
                  )),
            )),
        ElevatedButton(
            style: const ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Colors.white)),
            onPressed: () async {
              _formKey.currentState?.saveAndValidate();
              if (!_formKey.currentState!.isValid) return;
              var formInfo = Map.from(_formKey.currentState!.value);

              Authorization.email = formInfo["email"];
              Authorization.password = formInfo["password"];
              try {
                var loginResponse = await _authProvider.login();
                if (loginResponse.result == 0) {
                  Authorization.generalUserId = loginResponse.roleId;
                  var user = await _generalUserProvider
                      .getFullInfo(loginResponse.roleId!);
                  UserInfo.user = user;
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => const HomeScreen()),
                      ModalRoute.withName("HomeScreen"));
                } else if (loginResponse.result == 1) {
                  if (context.mounted) {
                    showDialog(
                        context: context,
                        builder: ((context) => AlertDialog(
                              title: const Text("Login failed"),
                              content: const Text("Incorrect credentials"),
                              actions: [
                                TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text("OK",
                                        style: TextStyle(color: Colors.black))),
                              ],
                            )));
                  }
                }
              } on Exception catch (e) {
                if (context.mounted) {
                  AlertHelpers.showAlert(context, "Error", e.toString());
                }
              }
            },
            child: const Text("Login"))
      ],
    )));
  }
}
