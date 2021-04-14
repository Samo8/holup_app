import 'package:json_annotation/json_annotation.dart';

import 'address.dart';
import 'location.dart';

part 'accommodation.g.dart';

@JsonSerializable()
class Accommodation {
  final int id;
  final String name;
  final String phoneNumber;
  final String email;
  final String webPage;
  final String gender;
  final String age;
  final String type;
  final Address address;
  final Location location;

  const Accommodation({
    this.id,
    this.name,
    this.phoneNumber,
    this.email,
    this.webPage,
    this.gender,
    this.age,
    this.type,
    this.address,
    this.location,
  });

  factory Accommodation.fromJson(Map<String, dynamic> json) =>
      _$AccommodationFromJson(json);

  Map<String, dynamic> toJson() => _$AccommodationToJson(this);
}
