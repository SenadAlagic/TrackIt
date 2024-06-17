import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

@JsonSerializable()
class User {
  int? userId;
  String? firstName;
  String? lastName;
  String? email;
  String? username;

  User(this.userId, this.firstName, this.lastName, this.email, this.username);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
