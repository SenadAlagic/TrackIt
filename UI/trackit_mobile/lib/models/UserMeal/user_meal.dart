import 'package:json_annotation/json_annotation.dart';
import '../Meal/meal.dart';
part 'user_meal.g.dart';

@JsonSerializable()
class UserMeal {
  int? usersMealsId;
  int? userId;
  int? mealId;
  DateTime? dateConsumed;
  int? servings;
  Meal? meal;

  UserMeal(this.usersMealsId, this.userId, this.mealId, this.dateConsumed,
      this.servings, this.meal);

  factory UserMeal.fromJson(Map<String, dynamic> json) =>
      _$UserMealFromJson(json);

  Map<String, dynamic> toJson() => _$UserMealToJson(this);
}
