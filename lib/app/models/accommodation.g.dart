// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accommodation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Accommodation _$AccommodationFromJson(Map<String, dynamic> json) {
  return Accommodation(
    id: json['id'] as int,
    name: json['name'] as String,
    district: json['district'] as String,
    region: json['region'] as String,
    street: json['street'] as String,
    zipCode: json['zipCode'] as String,
    address: json['address'] as String,
    phoneNumber: json['phoneNumber'] as String,
    email: json['email'] as String,
    webPage: json['webPage'] as String,
    gender: json['gender'] as String,
    age: json['age'] as String,
    type: json['type'] as String,
    lat: (json['lat'] as num)?.toDouble(),
    lon: (json['lon'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$AccommodationToJson(Accommodation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'district': instance.district,
      'region': instance.region,
      'street': instance.street,
      'zipCode': instance.zipCode,
      'address': instance.address,
      'phoneNumber': instance.phoneNumber,
      'email': instance.email,
      'webPage': instance.webPage,
      'gender': instance.gender,
      'age': instance.age,
      'type': instance.type,
      'lat': instance.lat,
      'lon': instance.lon,
    };
