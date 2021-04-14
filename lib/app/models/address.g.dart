// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Address _$AddressFromJson(Map<String, dynamic> json) {
  return Address(
    region: json['region'] as String,
    district: json['district'] as String,
    city: json['city'] as String,
    street: json['street'] as String,
    postCode: json['postCode'] as String,
  );
}

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
      'district': instance.district,
      'region': instance.region,
      'city': instance.city,
      'street': instance.street,
      'postCode': instance.postCode,
    };
