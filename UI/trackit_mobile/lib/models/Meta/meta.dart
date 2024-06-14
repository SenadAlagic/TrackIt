import 'package:json_annotation/json_annotation.dart';
part 'meta.g.dart';

@JsonSerializable()
class Meta {
  int count = 0;
  int currentPage = 0;
  int totalPages = 0;
  bool hasPrevious = false;
  bool hasNext = false;

  Meta(this.count, this.currentPage, this.totalPages, this.hasPrevious,
      this.hasNext);

  factory Meta.fromJson(Map<String, dynamic> json) => _$MetaFromJson(json);

  Map<String, dynamic> toJson() => _$MetaToJson(this);
}
