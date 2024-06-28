// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'email_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmailRequest _$EmailRequestFromJson(Map<String, dynamic> json) => EmailRequest(
      json['sender'] as String?,
      json['recipient'] as String?,
      json['subject'] as String?,
      json['content'] as String?,
    );

Map<String, dynamic> _$EmailRequestToJson(EmailRequest instance) =>
    <String, dynamic>{
      'sender': instance.sender,
      'recipient': instance.recipient,
      'subject': instance.subject,
      'content': instance.content,
    };
