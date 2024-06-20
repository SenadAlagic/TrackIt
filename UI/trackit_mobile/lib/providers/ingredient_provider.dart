import '../models/Ingredient/ingredient.dart';
import 'base_provider.dart';

class IngredientProvider extends BaseProvider<Ingredient> {
  IngredientProvider() : super("Ingredient");

  @override
  Ingredient fromJson(data) {
    return Ingredient.fromJson(data);
  }
}
