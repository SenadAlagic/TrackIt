// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Meal _$MealFromJson(Map<String, dynamic> json) => Meal(
      (json['mealId'] as num?)?.toInt(),
      (json['fat'] as num?)?.toDouble(),
      (json['calories'] as num?)?.toDouble(),
      (json['carbs'] as num?)?.toDouble(),
      (json['protein'] as num?)?.toDouble(),
      json['name'] as String?,
      json['description'] as String?,
      json['image'] as String?,
      (json['mealsIngredients'] as List<dynamic>?)
          ?.map((e) => MealIngredient.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MealToJson(Meal instance) => <String, dynamic>{
      'mealId': instance.mealId,
      'fat': instance.fat,
      'calories': instance.calories,
      'carbs': instance.carbs,
      'protein': instance.protein,
      'name': instance.name,
      'description': instance.description,
      'image': instance.image,
      'mealsIngredients': instance.mealsIngredients,
    };
