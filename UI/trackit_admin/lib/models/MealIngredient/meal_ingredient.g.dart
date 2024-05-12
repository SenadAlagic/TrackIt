// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meal_ingredient.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MealIngredient _$MealIngredientFromJson(Map<String, dynamic> json) =>
    MealIngredient(
      json['mealIngredientsId'] as int?,
      json['mealId'] as int?,
      json['ingredientId'] as int?,
      json['ingredientQuantity'] as int?,
      json['ingredient'] == null
          ? null
          : Ingredient.fromJson(json['ingredient'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MealIngredientToJson(MealIngredient instance) =>
    <String, dynamic>{
      'mealIngredientsId': instance.mealIngredientsId,
      'mealId': instance.mealId,
      'ingredientId': instance.ingredientId,
      'ingredientQuantity': instance.ingredientQuantity,
      'ingredient': instance.ingredient,
    };
