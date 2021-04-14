import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import '../../../connection/http_requests.dart';
import '../../../models/accommodation.dart';

enum Status { UNKNOWN, FETCHING, DONE, ERROR }

class AccommodationFilteringController extends GetxController {
  RxList<Accommodation> accommodations = <Accommodation>[].obs;

  final selectedRegions = <String>[].obs;
  final selectedDistricts = <String>[].obs;
  final selectedServiceTypes = <String>[].obs;
  final selectedGenders = <String>[].obs;
  final selectedAges = <String>[].obs;
  final distanceFromActualPossition = 0.0.obs;

  final selectedAccommodation = Accommodation().obs;

  var status = Status.UNKNOWN;

  Map<String, double> positionRequestArgs(Position position) {
    return <String, double>{
      'lat': position.latitude,
      'lng': position.longitude,
    };
  }

  Future<void> fetchAccommodations() async {
    try {
      status = Status.FETCHING;
      final arguments = <String, dynamic>{};

      if (distanceFromActualPossition.value != 0) {
        try {
          final position = await _determinePosition();
          arguments['location'] = positionRequestArgs(position);
          arguments['distance'] = distanceFromActualPossition.value.toDouble();
        } catch (e) {
          print(e.toString());
        }
      }

      if (selectedGenders.isNotEmpty && selectedGenders.length != 2) {
        arguments['gender'] = selectedGenders.first;
      }

      if (selectedServiceTypes.isNotEmpty) {
        final serviceTypes =
            selectedServiceTypes.map((e) => e.toLowerCase()).toList();
        selectedServiceTypes.assignAll(serviceTypes);
        arguments['type'] =
            selectedServiceTypes.map((e) => e.toLowerCase()).toList();
      }

      if (selectedRegions.isNotEmpty) {
        arguments['regions'] = selectedRegions.toJson();
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

      List<dynamic> data = json.decode(utf8DecodedData);

      print(data);

      accommodations
          .assignAll(data.map((e) => Accommodation.fromJson(e)).toList());
      status = Status.DONE;

      for (final accommodation in accommodations) {
        print(accommodation.id.toString() + accommodation.name);
      }
    } catch (_) {
      rethrow;
    }
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw 'Location services are disabled.';
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      throw 'Location permissions are permantly denied, we cannot request permissions.';
    }

    if (permission == LocationPermission.denied) {
      print('xxx');
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        throw 'Location permissions are denied (actual value: $permission).';
      }
    }

    return await Geolocator.getCurrentPosition();
  }
}
