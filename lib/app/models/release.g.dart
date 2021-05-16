// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'release.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Release _$ReleaseFromJson(Map<String, dynamic> json) {
  return Release(
    uuid: json['uuid'] as String,
    releaseDate: json['releaseDate'] as String,
  );
}

Map<String, dynamic> _$ReleaseToJson(Release instance) => <String, dynamic>{
      'uuid': instance.uuid,
      'releaseDate': instance.releaseDate,
    };
