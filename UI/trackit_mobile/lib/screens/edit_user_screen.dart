import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';

import '../models/requests/update_request.dart';
import '../providers/general_user_provider.dart';
import '../utils/alert_helpers.dart';
import '../utils/form_helpers.dart';
import '../utils/user_info.dart';
import 'master_screen.dart';

class EditUserScreen extends StatefulWidget {
  const EditUserScreen({super.key});

  @override
  State<EditUserScreen> createState() => _EditUserScreenState();
}

class _EditUserScreenState extends State<EditUserScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  late GeneralUserProvider _generalUserProvider;
  Map<String, dynamic> _initialValue = {};

  @override
  void initState() {
    super.initState();
    _generalUserProvider = context.read<GeneralUserProvider>();
    var user = UserInfo.user!.user;
    _initialValue = {
      "firstName": user?.firstName,
      "lastName": user?.lastName,
      "email": user?.email,
      "password": "",
      "passwordConfirm": "",
    };
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
                        "Edit your info",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      )),
                  FormHelpers.drawStringContainer("First name", "firstName",
                      customValidators: [FormBuilderValidators.minLength(3)]),
                  FormHelpers.drawStringContainer("Last name", "lastName",
                      customValidators: [FormBuilderValidators.minLength(3)]),
                  FormHelpers.drawStringContainer("Email", "email",
                      customValidators: [
                        FormBuilderValidators.email(
                            errorText: "Field must be a valid email")
                      ]),
                  FormHelpers.drawStringContainer("Password", "password",
                      customValidators: [FormBuilderValidators.minLength(5)],
                      obscureText: true),
                  FormHelpers.drawStringContainer(
                      "Confirm password", "passwordConfirm",
                      customValidators: [FormBuilderValidators.minLength(5)],
                      obscureText: true),
                  _drawSubmitButton()
                ],
              )
            ],
          ),
        ));
  }

  Widget _drawSubmitButton() {
    return ElevatedButton(
        style: const ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(Colors.white)),
        onPressed: () async {
          _formKey.currentState?.saveAndValidate();
          if (!_formKey.currentState!.isValid) return;
          Map<String, dynamic> request = Map.from(_formKey.currentState!.value);

          if (request['password'] != request['passwordConfirm']) {
            _formKey.currentState!.fields['passwordConfirm']
                ?.invalidate("Passwords must match");
          }

          UserUpdateRequest updateRequest =
              UserUpdateRequest.fromInitialValues(request);
          try {
            var newUserInfo = await _generalUserProvider.updateUser(
                UserInfo.user!.generalUserId!, updateRequest);

            UserInfo.user = newUserInfo;
            Navigator.of(context).pop();
          } on Exception catch (e) {
            if (context.mounted) {
              AlertHelpers.showAlert(context, "Error", e.toString());
            }
          }
        },
        child: const Text("Finish editing"));
  }
}
