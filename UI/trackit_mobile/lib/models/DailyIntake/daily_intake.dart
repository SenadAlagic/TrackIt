import 'package:json_annotation/json_annotation.dart';
part 'daily_intake.g.dart';

@JsonSerializable()
class DailyIntake {
  int? dailyIntakeId;
  int? userId;
  DateTime? day;
  double? calories;
  double? carbs;
  double? protein;
  double? fat;

  DailyIntake(this.dailyIntakeId, this.userId, this.day, this.calories,
      this.carbs, this.protein, this.fat);

  factory DailyIntake.fromJson(Map<String, dynamic> json) =>
      _$DailyIntakeFromJson(json);

  Map<String, dynamic> toJson() => _$DailyIntakeToJson(this);
}
