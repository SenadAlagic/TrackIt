// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_meal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserMeal _$UserMealFromJson(Map<String, dynamic> json) => UserMeal(
      (json['usersMealsId'] as num?)?.toInt(),
      (json['userId'] as num?)?.toInt(),
      (json['mealId'] as num?)?.toInt(),
      json['dateConsumed'] == null
          ? null
          : DateTime.parse(json['dateConsumed'] as String),
      (json['servings'] as num?)?.toInt(),
      json['meal'] == null
          ? null
          : Meal.fromJson(json['meal'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserMealToJson(UserMeal instance) => <String, dynamic>{
      'usersMealsId': instance.usersMealsId,
      'userId': instance.userId,
      'mealId': instance.mealId,
      'dateConsumed': instance.dateConsumed?.toIso8601String(),
      'servings': instance.servings,
      'meal': instance.meal,
    };
