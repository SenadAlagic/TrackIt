import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../models/Meta/meta.dart';
import '../models/search_result.dart';
import '../utils/string_helpers.dart';

abstract class BaseProvider<T> with ChangeNotifier {
  static String? _baseUrl;
  String _endpoint = "";
  final _storage = const FlutterSecureStorage();

  BaseProvider(String endpoint) {
    _endpoint = endpoint;
    _baseUrl = const String.fromEnvironment("baseUrl",
        defaultValue: "https://localhost:7296/");
  }

  String? getBaseUrl() => _baseUrl;

  Future<SearchResult<T>> get({dynamic filter}) async {
    var url = "$_baseUrl$_endpoint";

    if (filter != null) {
      var queryString = StringHelpers.getQueryString(filter);
      url = "$url?$queryString";
    }

    var uri = Uri.parse(url);
    var headers = await createHeaders();
    var response = await http.get(uri, headers: headers);

    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);
      var result = SearchResult<T>();
      result.meta = Meta.fromJson(data['meta']);

      for (var item in data['result']) {
        result.result.add(fromJson(item));
      }

      return result;
    } else {
      throw Exception("Unknown error in a GET request");
    }
  }

  Future<T> insert(dynamic request) async {
    var url = "$_baseUrl$_endpoint";
    var uri = Uri.parse(url);
    var headers = await createHeaders();

    var jsonRequest = jsonEncode(request);
    var response = await http.post(uri, headers: headers, body: jsonRequest);

    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);
      return fromJson(data);
    } else {
      throw Exception("Unknown error in an INSERT request");
    }
  }

  Future<T> update(int id, [dynamic request]) async {
    var url = "$_baseUrl$_endpoint/$id";
    var uri = Uri.parse(url);
    var headers = await createHeaders();

    var jsonRequest = jsonEncode(request);
    var response = await http.put(uri, headers: headers, body: jsonRequest);

    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);
      return fromJson(data);
    } else {
      throw Exception("Unknown error in an UPDATE request");
    }
  }

  Future<T> delete(int id) async {
    var url = "$_baseUrl$_endpoint/$id";
    var uri = Uri.parse(url);
    var headers = await createHeaders();

    var response = await http.delete(uri, headers: headers);
    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);
      return fromJson(data);
    } else {
      throw Exception("Unknown error in a DELETE request");
    }
  }

  T fromJson(data) {
    throw Exception("Method not implemented");
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
