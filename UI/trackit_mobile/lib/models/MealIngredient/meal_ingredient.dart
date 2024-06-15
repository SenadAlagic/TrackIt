import 'package:json_annotation/json_annotation.dart';
import '../Ingredient/ingredient.dart';
part 'meal_ingredient.g.dart';

@JsonSerializable()
class MealIngredient {
  int? mealIngredientsId;
  int? mealId;
  int? ingredientId;
  int? ingredientQuantity;
  Ingredient? ingredient;

  MealIngredient(this.mealIngredientsId, this.mealId, this.ingredientId,
      this.ingredientQuantity, this.ingredient);

  factory MealIngredient.fromJson(Map<String, dynamic> json) =>
      _$MealIngredientFromJson(json);

  Map<String, dynamic> toJson() => _$MealIngredientToJson(this);
}
