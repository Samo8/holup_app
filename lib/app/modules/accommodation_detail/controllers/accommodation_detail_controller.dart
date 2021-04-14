import 'package:get/get.dart';
import 'package:holup/app/modules/accommodation_filtering/controllers/accommodation_filtering_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class AccommodationDetailController extends GetxController {
  static const googleMapBaseURL =
      'https://www.google.com/maps/search/?api=1&query=';
  static const appleMapsBaseURL = 'https://maps.apple.com/?q=';

  Future<void> sendEmail(String email) async {
    final emailUri = Uri(
      scheme: 'mailto',
      path: email,
      queryParameters: {'subject': ''},
    );
    if (await canLaunch(emailUri.toString())) {
      await launch(emailUri.toString());
    } else {
      Get.snackbar('Chyba', 'Chyba email');
    }
  }

  Future<void> makeCall(String phoneNumber) async {
    final phone = 'tel://$phoneNumber';
    if (await canLaunch(phone)) {
      await launch(phone);
    } else {
      Get.snackbar('Chyba', 'Telefon chyba');
    }
  }

  Future<void> launchMap() async {
    final accommodation = Get.find<AccommodationFilteringController>()
        ?.selectedAccommodation
        ?.value;
    final lat = accommodation.location.lat;
    final lng = accommodation.location.lon;

    // final googleMapsUrl = "comgooglemaps://?center=$lat,$lng";
    final googleMapsUrl = '$googleMapBaseURL$lat,$lng';
    final appleMapsUrl = '$appleMapsBaseURL$lat,$lng';

    if (GetPlatform.isIOS && await canLaunch(appleMapsUrl)) {
      await launch(appleMapsUrl, forceSafariVC: false);
    } else if (await canLaunch(googleMapsUrl)) {
      await launch(googleMapsUrl);
    } else {
      throw 'Chybicka';
    }
  }
}
