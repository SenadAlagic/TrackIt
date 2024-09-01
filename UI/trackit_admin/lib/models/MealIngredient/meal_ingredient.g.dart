// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meal_ingredient.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MealIngredient _$MealIngredientFromJson(Map<String, dynamic> json) =>
    MealIngredient(
      (json['mealIngredientsId'] as num?)?.toInt(),
      (json['mealId'] as num?)?.toInt(),
      (json['ingredientId'] as num?)?.toInt(),
      (json['ingredientQuantity'] as num?)?.toInt(),
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
