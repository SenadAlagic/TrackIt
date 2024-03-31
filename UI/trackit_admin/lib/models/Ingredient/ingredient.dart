import 'package:json_annotation/json_annotation.dart';
part 'ingredient.g.dart';

@JsonSerializable()
class Ingredient {
  int? ingredientId;
  String? name;
  double? protein;
  double? fat;
  double? carbs;
  double? calories;
  String? image;

  Ingredient(this.ingredientId, this.fat, this.calories, this.carbs,
      this.protein, this.name, this.image);

  factory Ingredient.fromJson(Map<String, dynamic> json) =>
      _$IngredientFromJson(json);

  Map<String, dynamic> toJson() => _$IngredientToJson(this);
}
