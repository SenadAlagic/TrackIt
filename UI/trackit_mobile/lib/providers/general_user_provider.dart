import 'dart:convert';

import 'package:trackit_mobile/utils/string_helpers.dart';

import '../models/User/user.dart';
import 'base_provider.dart';

class GeneralUserProvider extends BaseProvider<User> {
  GeneralUserProvider() : super("GeneralUser");

  @override
  User fromJson(data) {
    return User.fromJson(data);
  }

  Future<User> selectActivityLevel(int id, int activityLevelId) async {
    var url = "${getBaseUrl()}selectActivityLevel/$id";
    var uri = Uri.parse(url);
    var headers = await createHeaders();

    var queryString =
        StringHelpers.getQueryString({"activityLevelId": activityLevelId});
    url = "$url?$queryString";

    var response = await http!.put(uri, headers: headers);
    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);
      return fromJson(data);
    } else {
      throw Exception("Unknown error in a PUT request");
    }
  }

  Future<User> selectGoal(int id, int goalId) async {
    var url = "${getBaseUrl()}selectGoal/$id";
    var uri = Uri.parse(url);
    var headers = await createHeaders();

    var queryString = StringHelpers.getQueryString({"goalId": goalId});
    url = "$url?$queryString";

    var response = await http!.put(uri, headers: headers);
    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);
      return fromJson(data);
    } else {
      throw Exception("Unknown error in a PUT request");
    }
  }

  Future<User?> addPreferences(int id, List<int> preferenceIds) async {
    var url = "${getBaseUrl()}addPreferences/$id";
    var queryString =
        StringHelpers.getQueryString({"preferenceIds": preferenceIds});
    url = "$url?$queryString";

    var uri = Uri.parse(url);
    var headers = await createHeaders();

    var response = await http!.put(uri, headers: headers);
    if (isValidResponse(response)) {
      if (response.body != "") {
        var data = jsonDecode(response.body);
        return fromJson(data);
      }
      return null;
    } else {
      throw Exception("Unknown error in a PUT request");
    }
  }
}
