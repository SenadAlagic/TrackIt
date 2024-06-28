import 'package:json_annotation/json_annotation.dart';

import '../User/user.dart';
part 'weight_over_time.g.dart';

@JsonSerializable()
class WeightOverTime {
  int? logId;
  int? userId;
  double? weight;
  String? dateLogged;
  String? comment;
  User? user;

  WeightOverTime(this.logId, this.userId, this.weight, this.dateLogged,
      this.comment, this.user);

  factory WeightOverTime.fromJson(Map<String, dynamic> json) =>
      _$WeightOverTimeFromJson(json);

  Map<String, dynamic> toJson() => _$WeightOverTimeToJson(this);
}
