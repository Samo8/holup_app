import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:holup/app/constants/constants.dart';
import 'package:holup/app/modules/accommodation_filtering/controllers/accommodation_filtering_controller.dart';
import 'package:holup/app/widgets/gender_icons.dart';

import '../controllers/accommodation_detail_controller.dart';

class AccommodationDetailView extends GetView<AccommodationDetailController> {
  final accommodationFilteringController =
      Get.find<AccommodationFilteringController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail zariadenia'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          const SizedBox(height: 16.0),
          ListTile(
            leading: const Icon(
              Icons.home,
              color: Constants.primaryColor,
            ),
            title: Text(
              accommodationFilteringController.selectedAccommodation.value.name,
            ),
          ),
          ListTile(
            leading: const FaIcon(
              FontAwesomeIcons.locationArrow,
              size: 18.0,
              color: Constants.primaryColor,
            ),
            title: Text(
              accommodationFilteringController
                  .selectedAccommodation.value.address
                  .toString(),
            ),
          ),
          ListTile(
            leading: LeadingIconWidget(
              accommodationFilteringController
                  .selectedAccommodation.value.gender,
            ),
            title: Text(
              accommodationFilteringController
                  .selectedAccommodation.value.gender,
            ),
          ),
          ListTile(
            leading: const FaIcon(
              FontAwesomeIcons.bed,
              color: Constants.primaryColor,
            ),
            title: Text(
              accommodationFilteringController.selectedAccommodation.value.type,
            ),
          ),
          const SizedBox(height: 12.0),
          Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 16.0,
              ),
              child: Wrap(
                alignment: WrapAlignment.spaceAround,
                children: [
                  InkWell(
                    child: Column(
                      children: [
                        const Icon(
                          Icons.email,
                          color: Constants.primaryColor,
                        ),
                        const Text('Email'),
                      ],
                    ),
                    onTap: () async {
                      await controller.sendEmail(
                          accommodationFilteringController
                              .selectedAccommodation.value.email);
                    },
                  ),
                  InkWell(
                    child: Column(
                      children: [
                        const Icon(
                          Icons.navigation,
                          color: Constants.primaryColor,
                        ),
                        const Text('Navigovať'),
                      ],
                    ),
                    onTap: () async {
                      try {
                        await controller.launchMap();
                      } catch (e) {
                        Get.snackbar('Chyba', e.toString());
                      }
                    },
                  ),
                  InkWell(
                    child: Column(
                      children: [
                        Icon(
                          Icons.phone,
                          color: Constants.primaryColor,
                        ),
                        const Text('Zavolať')
                      ],
                    ),
                    onTap: () async {
                      await controller.makeCall(accommodationFilteringController
                          .selectedAccommodation.value.phoneNumber);
                    },
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
