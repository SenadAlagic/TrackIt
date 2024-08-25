import 'package:json_annotation/json_annotation.dart';
part 'subscription.g.dart';

@JsonSerializable()
class Subscription {
  int? subscriptionId;
  int? generalUserId;
  DateTime? purchaseDate;

  Subscription(this.subscriptionId, this.generalUserId, this.purchaseDate);

  factory Subscription.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionFromJson(json);

  Map<String, dynamic> toJson() => _$SubscriptionToJson(this);
}
