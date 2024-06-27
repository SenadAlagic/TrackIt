import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:http/io_client.dart';

import '../models/Meal/meal.dart';

class RecommendationProvider with ChangeNotifier {
  static String? _baseUrl;
  final _storage = const FlutterSecureStorage();

  HttpClient client = HttpClient();
  IOClient? http;

  RecommendationProvider() {
    _baseUrl = const String.fromEnvironment("baseUrl",
        defaultValue: "https://10.0.2.2:7296/");

    if (_baseUrl!.endsWith("/") == false) {
      _baseUrl = "$_baseUrl/";
    }

    client.badCertificateCallback = (cert, host, port) => true;
    http = IOClient(client);
  }

  String? getBaseUrl() => _baseUrl;

  Future<Meal> get(int mealId) async {
    var url = "${_baseUrl}recommendMeal/$mealId";
    var uri = Uri.parse(url);
    var headers = await createHeaders();

    var response = await http!.get(uri, headers: headers);

    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);
      var result = Meal.fromJson(data);
      return result;
    } else {
      throw Exception("Unknown error in a GET request");
    }
  }

  bool isValidResponse(Response response) {
    if (response.statusCode < 299) {
      return true;
    } else if (response.statusCode == 401) {
      throw Exception("Unauthorized");
    } else {
      var body = jsonDecode(response.body);
      throw Exception(body['title']);
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
