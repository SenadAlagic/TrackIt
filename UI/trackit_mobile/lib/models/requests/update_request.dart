import 'package:json_annotation/json_annotation.dart';
part 'update_request.g.dart';

@JsonSerializable()
class UserUpdateRequest {
  String? firstName;
  String? lastName;
  String? email;
  String? password;
  String? passwordConfirm;

  UserUpdateRequest(this.firstName, this.lastName, this.email, this.password,
      this.passwordConfirm);

  factory UserUpdateRequest.fromInitialValues(
      Map<String, dynamic> initialValues) {
    return UserUpdateRequest(
      initialValues["firstName"] as String?,
      initialValues["lastName"] as String?,
      initialValues["email"] as String?,
      initialValues["password"] as String?,
      initialValues["passwordConfirm"] as String?,
    );
  }

  factory UserUpdateRequest.fromJson(Map<String, dynamic> json) =>
      _$UserUpdateRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UserUpdateRequestToJson(this);
}
