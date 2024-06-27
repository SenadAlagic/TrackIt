import '../models/Ingredient/ingredient.dart';
import 'package:http/http.dart' as http;
import 'base_provider.dart';

class IngredientProvider extends BaseProvider<Ingredient> {
  IngredientProvider() : super("Ingredient");

  @override
  Ingredient fromJson(data) {
    return Ingredient.fromJson(data);
  }

  Future<int> getForReport({dynamic filter}) async {
    var url = "${getBaseUrl()}Ingredient/getForReport";

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
