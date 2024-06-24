import 'package:json_annotation/json_annotation.dart';

import '../ActivityLevel/activity_level.dart';
import '../Goal/goal.dart';
import '../User/user.dart';
import '../UserPreferences/user_preferences.dart';
part 'general_user.g.dart';

@JsonSerializable()
class GeneralUser {
  int? generalUserId;
  int? userId;
  String? gender;
  DateTime? dateOfBirth;
  double? height;
  double? weight;
  double? targetWeight;
  int? activityLevelId;
  ActivityLevel? activityLevel;
  User? user;
  Goal? goal;
  bool? isUserPremium;
  List<UserPreferences>? usersPreferences;

  GeneralUser(
      this.generalUserId,
      this.userId,
      this.gender,
      this.dateOfBirth,
      this.height,
      this.weight,
      this.targetWeight,
      this.activityLevel,
      this.activityLevelId,
      this.user,
      this.goal,
      this.usersPreferences,
      this.isUserPremium);

  factory GeneralUser.fromJson(Map<String, dynamic> json) =>
      _$GeneralUserFromJson(json);

  Map<String, dynamic> toJson() => _$GeneralUserToJson(this);
}
