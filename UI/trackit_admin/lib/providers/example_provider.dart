import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class ExampleProvider with ChangeNotifier {
  static String? _baseUrl;
  final String _endpoint = "User/login";

  ExampleProvider() {
    _baseUrl = const String.fromEnvironment("baseUrl",
        defaultValue: "https://localhost:7296/");
  }

  Future<dynamic> get(String email, String password) async {
    var url = "$_baseUrl$_endpoint";
    var uri = Uri.parse(url);

    var body = jsonEncode({"email": email, "password": password});
    var response = await http
        .post(uri, body: body, headers: {"Content-Type": "application/json"});

    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception("Unknown error");
    }
  }

  bool isValidResponse(Response response) {
    if (response.statusCode < 299) {
      return true;
    } else if (response.statusCode == 401) {
      throw Exception("Unauthorized");
    } else {
      throw Exception(
          "${response.statusCode} Something bad happened, please try again later.");
    }
  }
}
