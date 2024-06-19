import 'package:flutter/material.dart';

class AlertHelpers {
  static void showAlert(
    context,
    title,
    text,
  ) {
    showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: Text(title),
              content: Text(text),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("OK"))
              ],
            ));
  }
}
