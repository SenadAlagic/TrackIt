// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
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
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
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
    };
