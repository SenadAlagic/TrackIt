import 'package:json_annotation/json_annotation.dart';

part 'email_request.g.dart';

@JsonSerializable()
class EmailRequest {
  String? sender;
  String? recipient;
  String? subject;
  String? content;

  EmailRequest(this.sender, this.recipient, this.subject, this.content);

  factory EmailRequest.fromJson(Map<String, dynamic> json) =>
      _$EmailRequestFromJson(json);

  Map<String, dynamic> toJson() => _$EmailRequestToJson(this);
}
