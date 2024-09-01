// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ingredient.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ingredient _$IngredientFromJson(Map<String, dynamic> json) => Ingredient(
      (json['ingredientId'] as num?)?.toInt(),
      (json['fat'] as num?)?.toDouble(),
      (json['calories'] as num?)?.toDouble(),
      (json['carbs'] as num?)?.toDouble(),
      (json['protein'] as num?)?.toDouble(),
      json['name'] as String?,
      json['image'] as String?,
    );

Map<String, dynamic> _$IngredientToJson(Ingredient instance) =>
    <String, dynamic>{
      'ingredientId': instance.ingredientId,
      'name': instance.name,
      'protein': instance.protein,
      'fat': instance.fat,
      'carbs': instance.carbs,
      'calories': instance.calories,
      'image': instance.image,
    };
