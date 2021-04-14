import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../../../widgets/gender_icons.dart';
import '../../accommodation_filtering/controllers/accommodation_filtering_controller.dart';
import '../controllers/accommodation_list_controller.dart';

class AccommodationListView extends GetView<AccommodationListController> {
  final accommodationFilteringController =
      Get.find<AccommodationFilteringController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ubytovanie'),
        centerTitle: true,
      ),
      body: Obx(
        () => accommodationFilteringController.accommodations.isEmpty
            ? accommodationFilteringController.status == Status.FETCHING
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Center(
                    child: Text(
                      'Nebolo nájdené žiadne ubytovanie, ktoré spĺňalo zadané parametre',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  )
            : Scrollbar(
                child: ListView.builder(
                  itemBuilder: (ctx, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 2.0,
                      ),
                      child: InkWell(
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: ListTile(
                              leading: LeadingIconWidget(
                                  accommodationFilteringController
                                      .accommodations[index].gender),
                              title: Text(
                                accommodationFilteringController
                                    .accommodations[index].name,
                              ),
                              subtitle: Text(
                                'Adresa: ${accommodationFilteringController.accommodations[index].address}\n'
                                'Typ: ${accommodationFilteringController.accommodations[index].type}',
                              ),
                            ),
                          ),
                        ),
                        onTap: () {
                          accommodationFilteringController
                                  .selectedAccommodation.value =
                              accommodationFilteringController
                                  .accommodations[index];
                          Get.toNamed(Routes.ACCOMMODATION_DETAIL);
                        },
                      ),
                    );
                  },
                  itemCount:
                      accommodationFilteringController.accommodations.length,
                ),
              ),
      ),
    );
  }
}
