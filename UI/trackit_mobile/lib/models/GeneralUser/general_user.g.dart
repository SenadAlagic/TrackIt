// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'general_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GeneralUser _$GeneralUserFromJson(Map<String, dynamic> json) => GeneralUser(
      (json['generalUserId'] as num?)?.toInt(),
      (json['userId'] as num?)?.toInt(),
      json['gender'] as String?,
      json['dateOfBirth'] == null
          ? null
          : DateTime.parse(json['dateOfBirth'] as String),
      (json['height'] as num?)?.toDouble(),
      (json['weight'] as num?)?.toDouble(),
      (json['targetWeight'] as num?)?.toDouble(),
      json['activityLevel'] == null
          ? null
          : ActivityLevel.fromJson(
              json['activityLevel'] as Map<String, dynamic>),
      (json['activityLevelId'] as num?)?.toInt(),
      json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
      json['goal'] == null
          ? null
          : Goal.fromJson(json['goal'] as Map<String, dynamic>),
      (json['usersPreferences'] as List<dynamic>?)
          ?.map((e) => UserPreferences.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GeneralUserToJson(GeneralUser instance) =>
    <String, dynamic>{
      'generalUserId': instance.generalUserId,
      'userId': instance.userId,
      'gender': instance.gender,
      'dateOfBirth': instance.dateOfBirth?.toIso8601String(),
      'height': instance.height,
      'weight': instance.weight,
      'targetWeight': instance.targetWeight,
      'activityLevelId': instance.activityLevelId,
      'activityLevel': instance.activityLevel,
      'user': instance.user,
      'goal': instance.goal,
      'usersPreferences': instance.usersPreferences,
    };
