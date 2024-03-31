// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tag.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Tag _$TagFromJson(Map<String, dynamic> json) => Tag(
      json['tagId'] as int?,
      json['name'] as String?,
      json['description'] as String?,
      json['color'] as String?,
    );

Map<String, dynamic> _$TagToJson(Tag instance) => <String, dynamic>{
      'tagId': instance.tagId,
      'name': instance.name,
      'description': instance.description,
      'color': instance.color,
    };
