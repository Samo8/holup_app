import 'package:json_annotation/json_annotation.dart';

part 'accommodation.g.dart';

@JsonSerializable()
class Accommodation {
  final int id;
  final String name;
  final String district;
  final String region;
  final String street;
  final String zipCode;
  final String address;
  final String phoneNumber;
  final String email;
  final String webPage;
  final String gender;
  final String age;
  final String type;
  final double lat;
  final double lon;

  const Accommodation({
    this.id,
    this.name,
    this.district,
    this.region,
    this.street,
    this.zipCode,
    this.address,
    this.phoneNumber,
    this.email,
    this.webPage,
    this.gender,
    this.age,
    this.type,
    this.lat,
    this.lon,
  });

  factory Accommodation.fromJson(Map<String, dynamic> json) =>
      _$AccommodationFromJson(json);

  Map<String, dynamic> toJson() => _$AccommodationToJson(this);
}
