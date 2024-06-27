import '../models/Meal/meal.dart';
import 'package:http/http.dart' as http;
import 'base_provider.dart';

class MealProvider extends BaseProvider<Meal> {
  MealProvider() : super("Meal");

  @override
  Meal fromJson(data) {
    return Meal.fromJson(data);
  }

  Future<void> setIngredients(mealId, ingredientsArray) async {
    var baseUrl = getBaseUrl();
    var url = "${baseUrl}setIngredients/$mealId";

    var uri = Uri.parse(url);
    var headers = await createHeaders();
    var response =
        await http.put(uri, headers: headers, body: ingredientsArray);

    if (!isValidResponse(response)) {
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
