import 'package:json_annotation/json_annotation.dart';

import '../User/user.dart';
part 'general_user.g.dart';

@JsonSerializable()
class GeneralUser {
  int? generalUserId;
  User? user;

  GeneralUser(this.generalUserId, this.user);

  factory GeneralUser.fromJson(Map<String, dynamic> json) =>
      _$GeneralUserFromJson(json);

  Map<String, dynamic> toJson() => _$GeneralUserToJson(this);
}
