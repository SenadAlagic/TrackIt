import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as dotenv;
import 'package:http/http.dart';
import 'package:http/io_client.dart';

import '../models/Auth/login_response.dart';
import '../screens/login_screen.dart';
import '../utils/authorization.dart';

class AuthProvider with ChangeNotifier {
  bool _isLoggedIn = false;
  static String? _baseUrl;
  final String _endpoint = "User/user_login";
  final _storage = const FlutterSecureStorage();

  HttpClient client = HttpClient();
  IOClient? http;

  AuthProvider() {
    _baseUrl = dotenv.dotenv.env["baseUrl"];

    if (_baseUrl!.endsWith("/") == false) {
      _baseUrl = "${_baseUrl!}/";
    }

    client.badCertificateCallback = (cert, host, port) => true;
    http = IOClient(client);
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
        await http!.post(uri, headers: headers, body: jsonEncode(body));

    if (isValidResponse(response)) {
      var data = LoginResponse.fromJson(jsonDecode(response.body));
      if (data.result == 0) {
        _storage.write(key: "jwt", value: data.token);
      }
      _isLoggedIn = true;
      return data;
    } else {
      throw Exception("Unknown error");
    }
  }

  void logout(BuildContext context) {
    _storage.delete(key: "jwt");
    _isLoggedIn = false;
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const LoginScreen()),
        ModalRoute.withName('LoginScreen'));
  }

  bool get isLoggedIn => _isLoggedIn;

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
    };

    if (token != "") {
      headers["Authorization"] = bearerAuth;
    }

    return headers;
  }
}
