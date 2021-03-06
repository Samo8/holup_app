import 'dart:async';
import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:holup/app/errors/location_permission_exception.dart';
import 'package:holup/app/routes/app_pages.dart';

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

  var status = Status.UNKNOWN.obs;

  Map<String, double> _usersPositionReguestArg(Position position) {
    return <String, double>{
      'lat': position.latitude,
      'lng': position.longitude,
    };
  }

  Future<void> fetchAccommodations() async {
    try {
      status.value = Status.FETCHING;
      final arguments = <String, dynamic>{};

      if (distanceFromActualPossition.value != 0.0) {
        final position = await _determinePosition();
        arguments['location'] = _usersPositionReguestArg(position);
        arguments['distance'] = distanceFromActualPossition.value.toDouble();
      }

      if (selectedGenders.isNotEmpty && selectedGenders.length != 2) {
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

      final response = await SpringDatabaseOperations.fetchAccommodationsData(
        arguments: arguments,
      );

      if (response.statusCode != 200) {
        status.value = Status.ERROR;
        Get.snackbar(
          'Nastala chyba',
          'Pri z??skavan?? ubytovac??ch zariaden?? nastala chyba, sk??ste to nesk??r pros??m',
        );
        return;
      }

      final utf8DecodedData = utf8.decode(response.bodyBytes);
      final List<dynamic> data = json.decode(utf8DecodedData);

      accommodations.assignAll(
        data.map((e) => Accommodation.fromJson(e)).toList(),
      );
      status.value = Status.DONE;
      await Get.toNamed(Routes.ACCOMMODATION_LIST);
    } on LocationPermissionException catch (e) {
      status.value = Status.ERROR;
      Get.snackbar('Pr??stup ku polohe', e.toString());
    } catch (_) {
      status.value = Status.ERROR;
      Get.snackbar(
        'Nastala chyba',
        'Pri z??skavan?? ubytovac??ch zariaden?? nastala chyba, sk??ste to nesk??r pros??m',
      );
    }
  }

  Future<Position> _determinePosition() async {
    try {
      if (!await Geolocator.isLocationServiceEnabled()) {
        throw LocationPermissionException(
          'Pr??stup ku polohe zariadenia nie je povolen??.',
        );
      }

      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.deniedForever) {
        throw LocationPermissionException(
          'Pr??stup ku polohe zariadenia je zamietnut??, povo??te pros??m'
          ' pr??stup aplik??cii v nastaveniach zariadenia.',
        );
      }

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission != LocationPermission.whileInUse &&
            permission != LocationPermission.always) {
          throw LocationPermissionException(
            'Pr??stup ku polohe nie je povolen?? (aktu??lny stav: $permission).',
          );
        }
      }

      return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.lowest,
        timeLimit: const Duration(seconds: 10),
      );
    } on TimeoutException catch (_) {
      return await Geolocator.getLastKnownPosition();
    } catch (e) {
      throw LocationPermissionException(e.toString());
    }
  }
}
