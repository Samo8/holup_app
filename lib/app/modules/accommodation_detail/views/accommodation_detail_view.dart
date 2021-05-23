import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:holup/app/widgets/accommodation_detail_item.dart';

import '../../../constants/constants.dart';
import '../../../widgets/gender_icons.dart';
import '../../accommodation_filtering/controllers/accommodation_filtering_controller.dart';
import '../controllers/accommodation_detail_controller.dart';

class AccommodationDetailView extends GetView<AccommodationDetailController> {
  final accommodationFilteringController =
      Get.find<AccommodationFilteringController>();

  @override
  Widget build(BuildContext context) {
    final accommodation =
        accommodationFilteringController.selectedAccommodation.value;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail ubytovania'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          const SizedBox(height: 16.0),
          AccommodationDetailItem(
            text: accommodation.name,
            leadingIcon: const Icon(
              Icons.home,
              color: Constants.primaryColor,
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.0),
              topRight: Radius.circular(15.0),
            ),
          ),
          AccommodationDetailItem(
            text: accommodation.address.toString(),
            leadingIcon: const FaIcon(
              FontAwesomeIcons.locationArrow,
              size: 18.0,
              color: Constants.primaryColor,
            ),
          ),
          AccommodationDetailItem(
            text: accommodation.gender,
            leadingIcon: LeadingIconWidget(
              accommodationFilteringController
                  .selectedAccommodation.value.gender,
            ),
          ),
          AccommodationDetailItem(
            text: accommodation.type,
            leadingIcon: const FaIcon(
              FontAwesomeIcons.bed,
              color: Constants.primaryColor,
            ),
          ),
          AccommodationDetailItem(
            text: accommodation.age,
            leadingIcon: const FaIcon(
              FontAwesomeIcons.birthdayCake,
              color: Constants.primaryColor,
            ),
          ),
          AccommodationDetailItem(
            text: accommodation.price,
            leadingIcon: const Icon(
              Icons.attach_money,
              color: Constants.primaryColor,
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15.0),
              bottomRight: Radius.circular(15.0),
            ),
          ),
          const SizedBox(height: 12.0),
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 12.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
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
                  ),
                  InkWell(
                    child: Column(
                      children: [
                        Icon(
                          Icons.web,
                          color: Constants.primaryColor,
                        ),
                        const Text('Web')
                      ],
                    ),
                    onTap: () async => await controller.openWebPage(
                      accommodationFilteringController
                          .selectedAccommodation.value.webPage,
                    ),
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
                    onTap: () async => await controller.launchMap(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
