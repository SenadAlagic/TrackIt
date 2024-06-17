// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_intake.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DailyIntake _$DailyIntakeFromJson(Map<String, dynamic> json) => DailyIntake(
      (json['dailyIntakeId'] as num?)?.toInt(),
      (json['userId'] as num?)?.toInt(),
      json['day'] == null ? null : DateTime.parse(json['day'] as String),
      (json['calories'] as num?)?.toDouble(),
      (json['carbs'] as num?)?.toDouble(),
      (json['protein'] as num?)?.toDouble(),
      (json['fat'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$DailyIntakeToJson(DailyIntake instance) =>
    <String, dynamic>{
      'dailyIntakeId': instance.dailyIntakeId,
      'userId': instance.userId,
      'day': instance.day?.toIso8601String(),
      'calories': instance.calories,
      'carbs': instance.carbs,
      'protein': instance.protein,
      'fat': instance.fat,
    };
