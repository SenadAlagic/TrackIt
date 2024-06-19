import 'package:json_annotation/json_annotation.dart';
part 'admin.g.dart';

@JsonSerializable()
class Admin {
  String? firstName;
  String? lastName;
  String? email;
  String? username;
  String? password;

  Admin(
      this.firstName, this.lastName, this.email, this.username, this.password);

  factory Admin.fromInitialValues(Map<String, dynamic> initialValues) {
    return Admin(
      initialValues["firstName"] as String?,
      initialValues["lastName"] as String?,
      initialValues["email"] as String?,
      initialValues["username"] as String?,
      initialValues["password"] as String?,
    );
  }

  factory Admin.fromJson(Map<String, dynamic> json) => _$AdminFromJson(json);

  Map<String, dynamic> toJson() => _$AdminToJson(this);
}
