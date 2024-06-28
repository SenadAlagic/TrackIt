// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weight_over_time.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeightOverTime _$WeightOverTimeFromJson(Map<String, dynamic> json) =>
    WeightOverTime(
      (json['logId'] as num?)?.toInt(),
      (json['userId'] as num?)?.toInt(),
      (json['weight'] as num?)?.toDouble(),
      json['dateLogged'] as String?,
      json['comment'] as String?,
      json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WeightOverTimeToJson(WeightOverTime instance) =>
    <String, dynamic>{
      'logId': instance.logId,
      'userId': instance.userId,
      'weight': instance.weight,
      'dateLogged': instance.dateLogged,
      'comment': instance.comment,
      'user': instance.user,
    };
