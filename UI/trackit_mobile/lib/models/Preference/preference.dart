import 'package:json_annotation/json_annotation.dart';
part 'preference.g.dart';

@JsonSerializable()
class Preference {
  int? preferenceId;
  String? name;

  Preference(this.preferenceId, this.name);

  factory Preference.fromJson(Map<String, dynamic> json) =>
      _$PreferenceFromJson(json);

  Map<String, dynamic> toJson() => _$PreferenceToJson(this);
}
