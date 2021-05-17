import 'package:flutter/material.dart';

import 'constants.dart';

abstract class ThemeConstants {
  static final lightTheme = ThemeData().copyWith(
    primaryColor: Constants.primaryColor,
    elevatedButtonTheme: elevatedButtonTheme,
    inputDecorationTheme: InputDecorationTheme(
      enabledBorder: enabledBorder,
      focusedBorder: focusedBorder,
    ),
  );
  static final darkTheme = ThemeData.dark().copyWith(
    primaryColor: Constants.primaryColor,
    elevatedButtonTheme: elevatedButtonTheme,
  );

  static final elevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      primary: Constants.primaryColor,
    ),
  );

  static final enabledBorder = const OutlineInputBorder(
    borderSide: BorderSide(
      color: Constants.primaryColor,
      width: 1.0,
    ),
  );

  static final focusedBorder = const OutlineInputBorder(
    borderSide: BorderSide(
      color: Constants.primaryColor,
      width: 1.0,
    ),
  );
}
