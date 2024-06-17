import 'package:json_annotation/json_annotation.dart';

import '../ActivityLevel/activity_level.dart';
part 'user_register.g.dart';

@JsonSerializable()
class UserRegister {
  int? generalUserId;
  int? userId;
  String? firstName;
  String? lastName;
  String? email;
  String? username;
  String? password;
  String? gender;
  DateTime? dateOfBirth;
  double? height;
  double? weight;
  double? targetWeight;
  int? activityLevelId;
  ActivityLevel? activityLevel;

  UserRegister(
      this.generalUserId,
      this.userId,
      this.firstName,
      this.lastName,
      this.email,
      this.username,
      this.password,
      this.gender,
      this.dateOfBirth,
      this.height,
      this.weight,
      this.targetWeight,
      this.activityLevelId,
      this.activityLevel);

  factory UserRegister.fromJson(Map<String, dynamic> json) =>
      _$UserRegisterFromJson(json);

  Map<String, dynamic> toJson() => _$UserRegisterToJson(this);
}
