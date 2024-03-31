import 'package:json_annotation/json_annotation.dart';
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

  Meal(this.mealId, this.fat, this.calories, this.carbs, this.protein,
      this.name, this.description, this.image);

  factory Meal.fromJson(Map<String, dynamic> json) => _$MealFromJson(json);

  Map<String, dynamic> toJson() => _$MealToJson(this);
}
