import 'package:json_annotation/json_annotation.dart';
part 'goal.g.dart';

@JsonSerializable()
class Goal {
  int? goalId;
  String? name;
  String? description;
  double? targetProtein;
  double? targetCalories;

  Goal(this.goalId, this.name, this.description, this.targetProtein,
      this.targetCalories);

  factory Goal.fromJson(Map<String, dynamic> json) => _$GoalFromJson(json);

  Map<String, dynamic> toJson() => _$GoalToJson(this);
}
