// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_register.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserRegister _$UserRegisterFromJson(Map<String, dynamic> json) => UserRegister(
      (json['generalUserId'] as num?)?.toInt(),
      (json['userId'] as num?)?.toInt(),
      json['firstName'] as String?,
      json['lastName'] as String?,
      json['email'] as String?,
      json['username'] as String?,
      json['password'] as String?,
      json['gender'] as String?,
      json['dateOfBirth'] == null
          ? null
          : DateTime.parse(json['dateOfBirth'] as String),
      (json['height'] as num?)?.toDouble(),
      (json['weight'] as num?)?.toDouble(),
      (json['targetWeight'] as num?)?.toDouble(),
      (json['activityLevelId'] as num?)?.toInt(),
      json['activityLevel'] == null
          ? null
          : ActivityLevel.fromJson(
              json['activityLevel'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserRegisterToJson(UserRegister instance) =>
    <String, dynamic>{
      'generalUserId': instance.generalUserId,
      'userId': instance.userId,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'username': instance.username,
      'password': instance.password,
      'gender': instance.gender,
      'dateOfBirth': instance.dateOfBirth?.toIso8601String(),
      'height': instance.height,
      'weight': instance.weight,
      'targetWeight': instance.targetWeight,
      'activityLevelId': instance.activityLevelId,
      'activityLevel': instance.activityLevel,
    };
