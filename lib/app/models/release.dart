import 'package:json_annotation/json_annotation.dart';

part 'release.g.dart';

@JsonSerializable()
class Release {
  final String uuid;
  final String releaseDate;

  const Release({
    this.uuid,
    this.releaseDate,
  });

  factory Release.fromJson(Map<String, dynamic> json) =>
      _$ReleaseFromJson(json);

  Map<String, dynamic> toJson() => _$ReleaseToJson(this);
}
