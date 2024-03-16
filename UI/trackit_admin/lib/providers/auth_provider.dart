import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:trackit_admin/models/Auth/login_response.dart';

import '../utils/authorization.dart';

class AuthProvider with ChangeNotifier {
  static String? _baseUrl;
  final String _endpoint = "User/login";

  AuthProvider() {
    _baseUrl = const String.fromEnvironment("baseUrl",
        defaultValue: "https://localhost:7296/");
  }

  Future<LoginResponse> login() async {
    var url = "$_baseUrl$_endpoint";
    var uri = Uri.parse(url);

    var body = {
      "email": Authorization.email,
      "password": Authorization.password
    };

    var response =
        await http.post(uri, headers: createHeaders(), body: jsonEncode(body));

    if (isValidResponse(response)) {
      var data = LoginResponse.fromJson(jsonDecode(response.body));
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

Map<String, String> createHeaders() {
  // String email = Authorization.email ?? "";
  // String password = Authorization.password ?? "";

  var headers = {
    "Content-Type": "application/json",
    // "Authorization": basicAuth
  };

  return headers;
}
