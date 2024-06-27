import 'package:http/http.dart' as http;
import '../models/Goal/goal.dart';
import 'base_provider.dart';

class GoalProvider extends BaseProvider<Goal> {
  GoalProvider() : super("Goal");

  @override
  Goal fromJson(data) {
    return Goal.fromJson(data);
  }

  Future<int> getForReport({dynamic filter}) async {
    var url = "${getBaseUrl()}Goal/getForReport";

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
