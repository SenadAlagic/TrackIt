import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

@JsonSerializable()
class User {
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

  User(
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
      this.targetWeight);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
