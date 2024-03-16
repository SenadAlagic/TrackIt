// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_level.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActivityLevel _$ActivityLevelFromJson(Map<String, dynamic> json) =>
    ActivityLevel(
      json['activityLevelId'] as int?,
      json['name'] as String?,
      (json['multiplier'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$ActivityLevelToJson(ActivityLevel instance) =>
    <String, dynamic>{
      'activityLevelId': instance.activityLevelId,
      'name': instance.name,
      'multiplier': instance.multiplier,
    };
