import 'package:json_annotation/json_annotation.dart';

import '../MealIngredient/meal_ingredient.dart';
part 'meal.g.dart';

@JsonSerializable()
class Meal {
  int? mealId;
  double? fat;
  double? calories;
  double? carbs;
  double? protein;
  String? name;
  String? description;
  String? image;
  List<MealIngredient>? mealsIngredients;

  Meal(this.mealId, this.fat, this.calories, this.carbs, this.protein,
      this.name, this.description, this.image, this.mealsIngredients);

  factory Meal.fromJson(Map<String, dynamic> json) => _$MealFromJson(json);

  Map<String, dynamic> toJson() => _$MealToJson(this);
}
