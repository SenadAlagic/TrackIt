// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'general_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GeneralUser _$GeneralUserFromJson(Map<String, dynamic> json) => GeneralUser(
      (json['generalUserId'] as num?)?.toInt(),
      json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GeneralUserToJson(GeneralUser instance) =>
    <String, dynamic>{
      'generalUserId': instance.generalUserId,
      'user': instance.user,
    };
