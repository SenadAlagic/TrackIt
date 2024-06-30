import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as dotenv;

class RecommendationProvider with ChangeNotifier {
  static String? _baseUrl;
  final _storage = const FlutterSecureStorage();

  RecommendationProvider() {
    _baseUrl = dotenv.dotenv.env["baseUrl"];

    if (_baseUrl!.endsWith("/") == false) {
      _baseUrl = "$_baseUrl/";
    }
  }

  Future<void> deleteAllRecommendation() async {
    var url = "${_baseUrl}deleteRecommendations";

    var uri = Uri.parse(url);
    var headers = await createHeaders();
    var response = await http.get(uri, headers: headers);

    if (isValidResponse(response)) {
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
