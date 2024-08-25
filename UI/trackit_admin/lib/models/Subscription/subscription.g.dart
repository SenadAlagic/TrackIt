// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Subscription _$SubscriptionFromJson(Map<String, dynamic> json) => Subscription(
      json['subscriptionId'] as int?,
      json['generalUserId'] as int?,
      json['purchaseDate'] == null
          ? null
          : DateTime.parse(json['purchaseDate'] as String),
    );

Map<String, dynamic> _$SubscriptionToJson(Subscription instance) =>
    <String, dynamic>{
      'subscriptionId': instance.subscriptionId,
      'generalUserId': instance.generalUserId,
      'purchaseDate': instance.purchaseDate?.toIso8601String(),
    };
