import 'package:http/http.dart' as http;
import '../models/Tag/tag.dart';
import 'base_provider.dart';

class TagProvider extends BaseProvider<Tag> {
  TagProvider() : super("Tag");

  @override
  Tag fromJson(data) {
    return Tag.fromJson(data);
  }

  Future<int> getForReport({dynamic filter}) async {
    var url = "${getBaseUrl()}Tag/getForReport";

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
