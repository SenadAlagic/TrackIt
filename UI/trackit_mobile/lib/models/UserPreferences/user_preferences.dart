import 'package:json_annotation/json_annotation.dart';

import '../Preference/preference.dart';
part 'user_preferences.g.dart';

@JsonSerializable()
class UserPreferences {
  int? userPreferenceId;
  int? userId;
  int? preferenceId;
  Preference? preference;

  UserPreferences(
      this.userPreferenceId, this.userId, this.preference, this.preferenceId);

  factory UserPreferences.fromJson(Map<String, dynamic> json) =>
      _$UserPreferencesFromJson(json);

  Map<String, dynamic> toJson() => _$UserPreferencesToJson(this);
}
