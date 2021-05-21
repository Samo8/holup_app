import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccommodationHeader extends StatelessWidget {
  final String title;
  final String description;

  const AccommodationHeader({
    @required this.title,
    @required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              title,
              style: Get.textTheme.headline4,
            ),
            const SizedBox(
              height: 12.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                description,
                style: Get.textTheme.subtitle1.copyWith(
                  letterSpacing: 1.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
