import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../models/Meal/meal.dart';

class UsersMealsProvider with ChangeNotifier {
  static String? _baseUrl;
  final _storage = const FlutterSecureStorage();

  UsersMealsProvider() {
    _baseUrl = const String.fromEnvironment("baseUrl",
        defaultValue: "http://localhost:7296/");

    if (_baseUrl!.endsWith("/") == false) {
      _baseUrl = "$_baseUrl/";
    }
  }

  Future<List<Meal>> getMostPopularMeals() async {
    var url = "${_baseUrl}getMostPopularMeals";

    var uri = Uri.parse(url);
    var headers = await createHeaders();
    var response = await http.get(uri, headers: headers);

    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);
      var mealList = List<Meal>.empty(growable: true);
      for (var item in data) {
        mealList.add(Meal.fromJson(item));
      }
      return mealList;
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
      "Authorization": bearerAuth
    };

    return headers;
  }
}
