// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'preference.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Preference _$PreferenceFromJson(Map<String, dynamic> json) => Preference(
      (json['preferenceId'] as num?)?.toInt(),
      json['name'] as String?,
    );

Map<String, dynamic> _$PreferenceToJson(Preference instance) =>
    <String, dynamic>{
      'preferenceId': instance.preferenceId,
      'name': instance.name,
    };
