import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'address.g.dart';

@JsonSerializable()
class Address {
  final String district;
  final String region;
  final String city;
  final String street;
  final String postCode;

  const Address({
    @required this.region,
    @required this.district,
    @required this.city,
    @required this.street,
    @required this.postCode,
  });

  @override
  String toString() {
    return '$street, $postCode $city';
  }

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);

  Map<String, dynamic> toJson() => _$AddressToJson(this);
}
