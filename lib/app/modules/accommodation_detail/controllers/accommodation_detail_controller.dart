import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../accommodation_filtering/controllers/accommodation_filtering_controller.dart';

class AccommodationDetailController extends GetxController {
  static const _phoneContact = 'Telefonický kontakt';
  static const _emailContact = 'Emailový kontakt';
  static const _webPage = 'Webová stránka';

  static const _googleMapBaseURL =
      'https://www.google.com/maps/search/?api=1&query=';
  static const _appleMapsBaseURL = 'https://maps.apple.com/?q=';

  Future<void> sendEmail(String email) async {
    final emailUri = Uri(
      scheme: 'mailto',
      path: email,
      query: 'subject=Holup',
    );
    final url = emailUri.toString();

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      if (email.isNotEmpty) {
        await _cantOpenAppDialog(_emailContact, email);
      } else {
        Get.snackbar(
          _emailContact,
          'Zariadenie nemá uvedený emailový kontakt',
          duration: const Duration(seconds: 5),
        );
      }
    }
  }

  Future<void> makeCall(String phoneNumber) async {
    final phone = 'tel://$phoneNumber';

    if (await canLaunch(phone)) {
      await launch(phone);
    } else {
      if (phoneNumber.isNotEmpty) {
        await _cantOpenAppDialog(_phoneContact, phoneNumber);
      } else {
        Get.snackbar(
          _phoneContact,
          'Zariadenie nemá uvedený telefonický kontakt',
          duration: const Duration(seconds: 5),
        );
      }
    }
  }

  Future<void> openWebPage(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      if (url.isNotEmpty) {
        await _cantOpenAppDialog(_webPage, url);
      } else {
        Get.snackbar(
          _webPage,
          'Zariadenie nemá uvedenú webovú stránku',
          duration: const Duration(seconds: 5),
        );
      }
    }
  }

  Future<void> launchMap() async {
    final accommodation = Get.find<AccommodationFilteringController>()
        ?.selectedAccommodation
        ?.value;
    final lat = accommodation.location.lat;
    final lng = accommodation.location.lon;

    final googleMapsUrl = '$_googleMapBaseURL$lat,$lng';
    final appleMapsUrl = '$_appleMapsBaseURL$lat,$lng';

    if (GetPlatform.isIOS && await canLaunch(appleMapsUrl)) {
      await launch(appleMapsUrl, forceSafariVC: false);
    } else if (await canLaunch(googleMapsUrl)) {
      await launch(googleMapsUrl);
    } else {
      Get.snackbar(
        'Nepodarilo sa spustiť navigáciu',
        'Navigácia nebola spustená',
      );
    }
  }

  Future<void> _cantOpenAppDialog(String title, String body) async {
    await showDialog(
      context: Get.context,
      builder: (_) => AlertDialog(
        title: Text(title),
        content: SelectableText(body),
        actions: [
          FlatButton(
            child: const Text('Zrušiť'),
            onPressed: () => Get.back(),
          ),
        ],
      ),
    );
  }
}
