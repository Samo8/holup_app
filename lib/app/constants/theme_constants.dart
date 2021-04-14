import 'package:flutter/material.dart';
import 'package:holup/app/constants/constants.dart';

abstract class ThemeConstants {
  static final lightTheme = ThemeData().copyWith(
    primaryColor: Constants.primaryColor,
    elevatedButtonTheme: elevatedButtonTheme,
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
}
