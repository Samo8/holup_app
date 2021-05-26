import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

import '../../../constants/constants.dart';
import '../../../widgets/accommodation_header.dart';
import '../controllers/accommodation_filtering_controller.dart';

class AccommodationFilteringView
    extends GetView<AccommodationFilteringController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vyhľadávanie ubytovania'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Scrollbar(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  children: [
                    const AccommodationHeader(
                      title: 'Podľa lokality',
                      description:
                          'Ubytovacie služby poskytujú organizácie v rôznych častiach'
                          ' Slovenska. Ak hľadáš zariadenie v konkrétnom kraji, okrese alebo'
                          ' aj viacerých súčastne, použi uvedený filter.',
                    ),
                    const SizedBox(height: 8.0),
                    MultiSelectDialogField<String>(
                      title: const Text('Kraje'),
                      buttonText: const Text('Kraje'),
                      items: Constants.regions
                          .map((region) => MultiSelectItem(region, region))
                          .toList(),
                      listType: MultiSelectListType.CHIP,
                      onConfirm: (values) =>
                          controller.selectedRegions.assignAll(values),
                    ),
                    const SizedBox(height: 16.0),
                    MultiSelectDialogField<String>(
                      title: const Text('Okresy'),
                      buttonText: const Text('Okresy'),
                      items: Constants.districts
                          .map((district) => MultiSelectItem(
                                district,
                                district,
                              ))
                          .toList(),
                      listType: MultiSelectListType.LIST,
                      onConfirm: (values) =>
                          controller.selectedDistricts.assignAll(values),
                    ),
                    const SizedBox(height: 16.0),
                    const AccommodationHeader(
                      title: 'Podľa mojej polohy',
                      description:
                          'Ak potrebuješ nájsť ubytovanie, ktoré je k tebe v danom momente'
                          ' najbližšie, použi uvedený filter. Vyhľadávanie môže trvať až 10 sekúnd.',
                    ),
                    const SizedBox(height: 8.0),
                    Obx(
                      () => Slider(
                        value: controller.distanceFromActualPossition.value,
                        min: 0.0,
                        max: 200.0,
                        divisions: 40,
                        label: controller.distanceFromActualPossition.value
                            .round()
                            .toString(),
                        onChanged: (value) => controller
                            .distanceFromActualPossition.value = value,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    const AccommodationHeader(
                      title: 'Podľa typu služby',
                      description:
                          'Podľa charakteru poskytovaných služieb môžeš vyhľadávať viaceré'
                          ' druhy zariadení.',
                    ),
                    MultiSelectDialogField<String>(
                      title: const Text('Typy zariadení'),
                      buttonText: const Text('Typy zariadení'),
                      items: Constants.types
                          .map((type) => MultiSelectItem(type, type))
                          .toList(),
                      listType: MultiSelectListType.CHIP,
                      onConfirm: (values) =>
                          controller.selectedServiceTypes.assignAll(values),
                    ),
                    const AccommodationHeader(
                      title: 'Podľa pohlavia',
                      description:
                          'Niektoré zariadenia môžu mať obmedzené poskytovanie svojich'
                          ' služieb pre mužov alebo ženy. Vyber o aké ubytovanie máš záujem.',
                    ),
                    MultiSelectDialogField<String>(
                      title: const Text('Pohlavie'),
                      buttonText: const Text('Pohlavie'),
                      items: Constants.genders
                          .map((gender) => MultiSelectItem(gender, gender))
                          .toList(),
                      listType: MultiSelectListType.CHIP,
                      onConfirm: (values) =>
                          controller.selectedGenders.assignAll(values),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SafeArea(
            child: ElevatedButton.icon(
              label: const Text('Zobraziť ponuky'),
              icon: const Icon(Icons.remove_red_eye),
              onPressed: () async => controller.fetchAccommodations(),
              // onPressed: () => Get.toNamed(Routes.ACCOMMODATION_LIST),
            ),
          ),
        ],
      ),
    );
  }
}
