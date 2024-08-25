import 'dart:convert';

import 'package:trackit_admin/models/Subscription/subscription.dart';

import 'package:http/http.dart' as http;
import 'base_provider.dart';

class SubscriptionProvider extends BaseProvider<Subscription> {
  SubscriptionProvider() : super("Subscription");

  @override
  Subscription fromJson(data) {
    return Subscription.fromJson(data);
  }

  Future<Map<String, int>> getGroupedByMonth() async {
    var url = "${getBaseUrl()}Subscription/getGroupedByMonth";

    var uri = Uri.parse(url);
    var headers = await createHeaders();
    var response = await http.get(uri, headers: headers);

    if (isValidResponse(response)) {
      Map<String, dynamic> data = jsonDecode(response.body);
      return data.cast<String, int>();
    } else {
      throw Exception("Unknown error in a PUT request");
    }
  }

  Future<int> getForReport({dynamic filter}) async {
    var url = "${getBaseUrl()}Meal/getForReport";

    var uri = Uri.parse(url);
    var headers = await createHeaders();
    var response = await http.get(uri, headers: headers);

    if (isValidResponse(response)) {
      var result = int.parse(response.body);
      return result;
    } else {
      throw Exception("Unknown error in a GET request");
    }
  }
}
