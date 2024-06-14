import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:trackit_mobile/models/UserData/user_data.dart';
import 'package:trackit_mobile/models/requests/register_request.dart';
import 'package:trackit_mobile/screens/add_goal_screen.dart';
import 'package:trackit_mobile/utils/form_helpers.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  Map<String, dynamic> _initialValue = {};

  @override
  void initState() {
    super.initState();
    _initialValue = {
      "firstName": "",
      "lastName": "",
      "email": "",
      "dateOfBirth": DateTime(DateTime.now().year - 18),
      "gender": "Male",
      "username": "",
      "password": "",
      "passwordConfirm": "",
      "height": "",
      "weight": "",
      "targetWeight": "",
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: SafeArea(child: SingleChildScrollView(child: _buildScreen())));
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
                    _drawDatePicker(),
                    _drawRadioButtons(),
                    FormHelpers.drawNumericContainer("Height (cm)", "height"),
                    FormHelpers.drawNumericContainer("Weight (kg)", "weight"),
                    FormHelpers.drawNumericContainer(
                        "Target weight (kg)", "targetWeight"),
                    const Divider(
                      height: 30,
                    ),
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

  Widget _drawDatePicker() {
    return Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        width: 300,
        constraints: const BoxConstraints(maxHeight: 70),
        child: Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: FormBuilderDateTimePicker(
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(
                      errorText: "Field is required"),
                ]),
                decoration: const InputDecoration(
                    label: Text("Date of birth"),
                    labelStyle: TextStyle(color: Colors.black),
                    hintText: "Date of birth*",
                    border: InputBorder.none,
                    suffixIcon: Icon(Icons.date_range)),
                inputType: InputType.date,
                name: "dateOfBirth")));
  }

  Widget _drawSubmitButton() {
    return ElevatedButton(
        style: const ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(Colors.white)),
        onPressed: () {
          _formKey.currentState?.saveAndValidate();
          if (!_formKey.currentState!.isValid) return;
          Map<String, dynamic> request = Map.from(_formKey.currentState!.value);

          if (request['password'] != request['passwordConfirm']) {
            _formKey.currentState!.fields['passwordConfirm']
                ?.invalidate("Passwords must match");
          }
          RegisterRequest user = RegisterRequest.fromInitialValues(request);
          UserData userData = UserData(user);

          Navigator.of(context).push(MaterialPageRoute(
              builder: ((context) => const AddGoalScreen()),
              settings: RouteSettings(arguments: userData)));
        },
        child: const Text("Next"));
  }

  Widget _drawRadioButtons() {
    return SizedBox(
        width: 300,
        child: FormBuilderRadioGroup(
            decoration: const InputDecoration(
                label: Text("Gender"), border: InputBorder.none),
            focusColor: Colors.black,
            activeColor: Colors.black,
            name: "gender",
            options: const [
              FormBuilderFieldOption(value: "Male"),
              FormBuilderFieldOption(value: "Female")
            ]));
  }
}
