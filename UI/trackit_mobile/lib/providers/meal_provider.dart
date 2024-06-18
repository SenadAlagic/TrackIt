import '../models/Meal/meal.dart';
import 'base_provider.dart';

class MealProvider extends BaseProvider<Meal> {
  MealProvider() : super("Meal");

  @override
  Meal fromJson(data) {
    return Meal.fromJson(data);
  }
}
