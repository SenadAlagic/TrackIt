import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class FormHelpers {
  static Widget drawStringContainer(String hint, String propertyName,
      {bool obscureText = false,
      int minLength = 5,
      int maxLength = 40,
      List<String? Function(String?)> customValidators = const []}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      alignment: Alignment.centerLeft,
      constraints: const BoxConstraints(maxHeight: 81, maxWidth: 300),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8),
          child: Column(children: [
            FormBuilderTextField(
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(errorText: "Field is required"),
                FormBuilderValidators.minLength(minLength),
                FormBuilderValidators.maxLength(maxLength),
                ...customValidators
              ]),
              name: propertyName,
              obscureText: obscureText,
              decoration: InputDecoration(
                label: Text(hint),
                labelStyle: const TextStyle(color: Colors.black),
                border: InputBorder.none,
                hintText: "$hint*",
              ),
            )
          ])),
    );
  }

  static Widget drawNumericContainer(String hint, String propertyName,
      {bool allowNegative = false, bool integer = false}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      alignment: Alignment.centerLeft,
      constraints: const BoxConstraints(maxHeight: 81, maxWidth: 300),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8),
          child: Column(children: [
            FormBuilderTextField(
              keyboardType: TextInputType.number,
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(errorText: "Field is required"),
                FormBuilderValidators.numeric(),
                integer
                    ? FormBuilderValidators.integer()
                    : FormBuilderValidators.numeric(),
                !allowNegative
                    ? FormBuilderValidators.positiveNumber()
                    : FormBuilderValidators.numeric(),
                FormBuilderValidators.min(0)
              ]),
              name: propertyName,
              decoration: InputDecoration(
                label: Text(hint),
                labelStyle: const TextStyle(color: Colors.black),
                border: InputBorder.none,
                hintText: "$hint*",
              ),
            )
          ])),
    );
  }

  static Widget drawProgressIndicator() {
    return const Center(
        child: Padding(
      padding: EdgeInsets.all(16),
      child: CircularProgressIndicator(
        color: Colors.black,
      ),
    ));
  }
}
