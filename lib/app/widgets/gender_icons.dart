import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../constants/constants.dart';

class LeadingIconWidget extends StatelessWidget {
  static const men = 'Muži';
  static const women = 'Ženy';

  final String gender;

  LeadingIconWidget(this.gender);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (gender.contains(men))
          const Padding(
            padding: EdgeInsets.all(2.0),
            child: FaIcon(
              FontAwesomeIcons.male,
              size: 24,
              color: Constants.primaryColor,
            ),
          ),
        if (gender.contains(women))
          const Padding(
            padding: EdgeInsets.all(2.0),
            child: FaIcon(
              FontAwesomeIcons.female,
              color: Constants.primaryColor,
            ),
          ),
      ],
    );
  }
}
