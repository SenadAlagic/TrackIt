import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as dotenv;

import '../models/Auth/login_response.dart';
import '../utils/authorization.dart';

class AuthProvider with ChangeNotifier {
  static String? _baseUrl;
  final String _endpoint = "User/admin_login";
  final _storage = const FlutterSecureStorage();

  AuthProvider() {
    _baseUrl = dotenv.dotenv.env["baseUrl"];
  }

  Future<LoginResponse> login() async {
    var url = "$_baseUrl$_endpoint";
    var uri = Uri.parse(url);

    var body = {
      "email": Authorization.email,
      "password": Authorization.password
    };
    var headers = await createHeaders();
    var response =
        await http.post(uri, headers: headers, body: jsonEncode(body));

    if (isValidResponse(response)) {
      var data = LoginResponse.fromJson(jsonDecode(response.body));
      if (data.result == 0) {
        _storage.write(key: "jwt", value: data.token);
      }
      return data;
    } else {
      throw Exception("Unknown error");
    }
  }

  void logout() {
    _storage.delete(key: "jwt");
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

  Future<Map<String, String>> createHeaders() async {
    String token = await _storage.read(key: "jwt") ?? "";
    String bearerAuth = "Bearer $token";
    var headers = {
      "Content-Type": "application/json",
      "Authorization": bearerAuth
    };

    return headers;
  }
}
