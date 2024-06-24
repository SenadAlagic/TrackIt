import 'dart:convert';

import '../models/GeneralUser/general_user.dart';
import '../models/requests/update_request.dart';
import '../utils/string_helpers.dart';
import 'base_provider.dart';

class GeneralUserProvider extends BaseProvider<GeneralUser> {
  GeneralUserProvider() : super("GeneralUser");

  @override
  GeneralUser fromJson(data) {
    return GeneralUser.fromJson(data);
  }

  Future<GeneralUser> selectActivityLevel(int id, int activityLevelId) async {
    var url = "${getBaseUrl()}selectActivityLevel/$id";
    var headers = await createHeaders();

    var queryString =
        StringHelpers.getQueryString({"activityLevelId": activityLevelId});
    url = "$url?$queryString";
    var uri = Uri.parse(url);

    var response = await http!.put(uri, headers: headers);
    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);
      return fromJson(data);
    } else {
      throw Exception("Unknown error in a PUT request");
    }
  }

  Future<GeneralUser> selectGoal(int id, int goalId) async {
    var url = "${getBaseUrl()}selectGoal/$id";
    var headers = await createHeaders();

    var queryString = StringHelpers.getQueryString({"goalId": goalId});
    url = "$url?$queryString";
    var uri = Uri.parse(url);

    var response = await http!.put(uri, headers: headers);
    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);
      return fromJson(data);
    } else {
      throw Exception("Unknown error in a PUT request");
    }
  }

  Future<GeneralUser?> addPreferences(int id, List<int> preferenceIds) async {
    var url = "${getBaseUrl()}selectPreferences/$id";
    var headers = await createHeaders();

    var queryString =
        StringHelpers.getQueryString({"preferenceIds": preferenceIds});
    url = "$url?$queryString";
    var uri = Uri.parse(url);

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

  Future<GeneralUser?> getFullInfo(int generalUserId) async {
    var url = "${getBaseUrl()}getFullInfo/$generalUserId";
    var uri = Uri.parse(url);
    var headers = await createHeaders();

    var response = await http!.get(uri, headers: headers);
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

  Future<GeneralUser?> updateUser(
      int generalUserId, UserUpdateRequest request) async {
    var url = "${getBaseUrl()}updateUser/$generalUserId";
    var uri = Uri.parse(url);
    var headers = await createHeaders();

    var jsonRequest = jsonEncode(request);
    var response = await http!.put(uri, headers: headers, body: jsonRequest);
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

  Future<GeneralUser?> upgradeToPremium(int generalUserId) async {
    var url = "${getBaseUrl()}upgradeAccountToPremium/$generalUserId";
    var uri = Uri.parse(url);
    var headers = await createHeaders();

    var response = await http!.get(uri, headers: headers);
    if (isValidResponse(response)) {
      if (response.body != "") {
        var data = jsonDecode(response.body);
        return fromJson(data);
      }
      return null;
    } else {
      throw Exception("Unknown error in GET request");
    }
  }
}
