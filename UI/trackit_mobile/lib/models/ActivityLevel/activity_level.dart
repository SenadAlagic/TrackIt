import 'package:json_annotation/json_annotation.dart';
part 'activity_level.g.dart';

@JsonSerializable()
class ActivityLevel {
  int? activityLevelId;
  String? name;
  double? multiplier;
  String? image;

  ActivityLevel(this.activityLevelId, this.name, this.multiplier, this.image);

  factory ActivityLevel.fromJson(Map<String, dynamic> json) =>
      _$ActivityLevelFromJson(json);

  Map<String, dynamic> toJson() => _$ActivityLevelToJson(this);
}
