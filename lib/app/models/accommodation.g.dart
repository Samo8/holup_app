// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accommodation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Accommodation _$AccommodationFromJson(Map<String, dynamic> json) {
  return Accommodation(
    id: json['id'] as int,
    name: json['name'] as String,
    phoneNumber: json['phoneNumber'] as String,
    email: json['email'] as String,
    webPage: json['webPage'] as String,
    gender: json['gender'] as String,
    age: json['age'] as String,
    type: json['type'] as String,
    address: json['address'] == null
        ? null
        : Address.fromJson(json['address'] as Map<String, dynamic>),
    location: json['location'] == null
        ? null
        : Location.fromJson(json['location'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$AccommodationToJson(Accommodation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phoneNumber': instance.phoneNumber,
      'email': instance.email,
      'webPage': instance.webPage,
      'gender': instance.gender,
      'age': instance.age,
      'type': instance.type,
      'address': instance.address,
      'location': instance.location,
    };
