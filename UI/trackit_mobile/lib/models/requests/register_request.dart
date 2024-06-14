class RegisterRequest {
  String? firstName;
  String? lastName;
  String? email;
  String? username;
  String? password;
  String? gender;
  String? dateOfBirth;
  double? height;
  double? weight;
  double? targetWeight;

  RegisterRequest(
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

  factory RegisterRequest.fromInitialValues(
      Map<String, dynamic> initialValues) {
    return RegisterRequest(
      initialValues["firstName"] as String?,
      initialValues["lastName"] as String?,
      initialValues["email"] as String?,
      initialValues["username"] as String?,
      initialValues["password"] as String?,
      initialValues['gender'] as String?,
      (initialValues['dateOfBirth'] as DateTime?)!.toIso8601String(),
      double.tryParse(initialValues["height"]),
      double.tryParse(initialValues["weight"]),
      double.tryParse(initialValues["targetWeight"]),
    );
  }
}
