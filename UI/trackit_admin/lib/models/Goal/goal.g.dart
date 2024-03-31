// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Goal _$GoalFromJson(Map<String, dynamic> json) => Goal(
      json['goalId'] as int?,
      json['name'] as String?,
      json['description'] as String?,
      (json['targetProtein'] as num?)?.toDouble(),
      (json['targetCalories'] as num?)?.toDouble(),
    )..image = json['image'] as String?;

Map<String, dynamic> _$GoalToJson(Goal instance) => <String, dynamic>{
      'goalId': instance.goalId,
      'name': instance.name,
      'description': instance.description,
      'targetProtein': instance.targetProtein,
      'targetCalories': instance.targetCalories,
      'image': instance.image,
    };
