import 'package:flutter/material.dart';

class AccommodationDetailItem extends StatelessWidget {
  final BorderRadiusGeometry borderRadius;
  final Widget leadingIcon;
  final String text;

  const AccommodationDetailItem({
    @required this.text,
    @required this.leadingIcon,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius ?? BorderRadius.zero,
      ),
      margin: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2.0),
        child: ListTile(
          leading: leadingIcon,
          title: Text(text),
        ),
      ),
    );
  }
}
