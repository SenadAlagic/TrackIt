import '../models/UserMeal/user_meal.dart';
import 'base_provider.dart';

class UserMealsProvider extends BaseProvider<UserMeal> {
  UserMealsProvider() : super("UserMeal");

  @override
  UserMeal fromJson(data) {
    return UserMeal.fromJson(data);
  }
}
