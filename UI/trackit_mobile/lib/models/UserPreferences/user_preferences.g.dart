// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_preferences.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserPreferences _$UserPreferencesFromJson(Map<String, dynamic> json) =>
    UserPreferences(
      (json['userPreferenceId'] as num?)?.toInt(),
      (json['userId'] as num?)?.toInt(),
      json['preference'] == null
          ? null
          : Preference.fromJson(json['preference'] as Map<String, dynamic>),
      (json['preferenceId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$UserPreferencesToJson(UserPreferences instance) =>
    <String, dynamic>{
      'userPreferenceId': instance.userPreferenceId,
      'userId': instance.userId,
      'preferenceId': instance.preferenceId,
      'preference': instance.preference,
    };
