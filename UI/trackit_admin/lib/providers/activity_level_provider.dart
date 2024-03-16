import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:trackit_admin/models/ActivityLevel/activity_level.dart';
import 'package:trackit_admin/models/search_result.dart';

class ActivityLevelProvider with ChangeNotifier {
  static String? _baseUrl;
  final String _endpoint = "ActivityLevel";

  ActivityLevelProvider() {
    _baseUrl = const String.fromEnvironment("baseUrl",
        defaultValue: "https://localhost:7296/");
  }

  Future<SearchResult<ActivityLevel>> get() async {
    var url = "$_baseUrl$_endpoint";
    var uri = Uri.parse(url);

    var response =
        await http.get(uri, headers: {"Content-Type": "application/json"});

    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);

      var result = SearchResult<ActivityLevel>();
      result.count = data['count'];

      for (var item in data['result']) {
        result.result.add(ActivityLevel.fromJson(item));
      }

      return result;
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
