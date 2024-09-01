// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meta.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Meta _$MetaFromJson(Map<String, dynamic> json) => Meta(
      (json['count'] as num).toInt(),
      (json['currentPage'] as num).toInt(),
      (json['totalPages'] as num).toInt(),
      json['hasPrevious'] as bool,
      json['hasNext'] as bool,
    );

Map<String, dynamic> _$MetaToJson(Meta instance) => <String, dynamic>{
      'count': instance.count,
      'currentPage': instance.currentPage,
      'totalPages': instance.totalPages,
      'hasPrevious': instance.hasPrevious,
      'hasNext': instance.hasNext,
    };
