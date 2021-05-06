import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import '../../../connection/http_requests.dart';
import '../../../models/accommodation.dart';

enum Status { UNKNOWN, FETCHING, DONE, ERROR }

class AccommodationFilteringController extends GetxController {
  final accommodations = <Accommodation>[].obs;

  final selectedRegions = <String>[].obs;
  final selectedDistricts = <String>[].obs;
  final selectedServiceTypes = <String>[].obs;
  final selectedGenders = <String>[].obs;
  final selectedAges = <String>[].obs;
  final distanceFromActualPossition = 0.0.obs;

  final selectedAccommodation = Accommodation().obs;

  var status = Status.UNKNOWN;

  Map<String, double> _usersPositionReguestArg(Position position) {
    return <String, double>{
      'lat': position.latitude,
      'lng': position.longitude,
    };
  }

  Future<void> fetchAccommodations() async {
    try {
      status = Status.FETCHING;
      final arguments = <String, dynamic>{};

      if (distanceFromActualPossition.value != 0.0) {
        final position = await _determinePosition();
        arguments['location'] = _usersPositionReguestArg(position);
        arguments['distance'] = distanceFromActualPossition?.value?.toDouble();
      }

      if (selectedGenders.isNotEmpty || selectedGenders.length != 2) {
        arguments['gender'] = selectedGenders.first;
      }

      if (selectedServiceTypes.isNotEmpty) {
        final serviceTypes =
            selectedServiceTypes.map((e) => e.toLowerCase()).toList();
        selectedServiceTypes.assignAll(serviceTypes);
        arguments['types'] =
            selectedServiceTypes.map((e) => e.toLowerCase()).toList();
      }

      if (selectedRegions.isNotEmpty) {
        arguments['regions'] = selectedRegions.toJson();
      }

      if (selectedDistricts.isNotEmpty) {
        arguments['districts'] = selectedDistricts.toJson();
      }

      if (selectedAges.isNotEmpty) {
        arguments['ages'] = selectedAges.toJson();
      }
      print(arguments);

      final response = await FlaskDatabaseOperations.fetchAccommodationsData(
        arguments: arguments,
      );

      if (response.statusCode != 200) {
        status = Status.ERROR;
        throw response.body;
      }

      final utf8DecodedData = utf8.decode(response.bodyBytes);

      final List<dynamic> data = json.decode(utf8DecodedData);

      print(data);

      accommodations
          .assignAll(data.map((e) => Accommodation.fromJson(e)).toList());
      status = Status.DONE;

      // for (final accommodation in accommodations) {
      //   print(accommodation.id.toString() + accommodation.name);
      // }
    } catch (_) {
      rethrow;
    }
  }

  Future<Position> _determinePosition() async {
    if (!await Geolocator.isLocationServiceEnabled()) {
      throw 'Prístup ku polohe zariadenia nie je povolený.';
      // 'Location services are disabled.';
    }

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      throw 'Prístup ku polohe zariadenia je zamietnutý, povoľte prosím'
          ' prístup aplikácii v nastaveniach zariadenia.';
      // 'Location permissions are permantly denied, we cannot request permissions.';
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        throw 'Location permissions are denied (actual value: $permission).';
        // 'Location permissions are denied (actual value: $permission).';
      }
    }

    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.low,
    );
  }
}
