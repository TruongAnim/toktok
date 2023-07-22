import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toktok/Theme/colors.dart';

final BorderRadius radius = BorderRadius.circular(6.0);

final ThemeData appTheme = ThemeData.light().copyWith(
  brightness: Brightness.light,
  scaffoldBackgroundColor: backgroundColor,
  primaryColor: mainColor,

  ///appBar theme
  appBarTheme: AppBarTheme(
    color: transparentColor,
    elevation: 0.0,
  ),

  ///text theme
  textTheme: GoogleFonts.openSansTextTheme().copyWith(
    titleSmall: TextStyle(color: disabledTextColor),
    labelLarge: TextStyle(color: disabledTextColor),
    bodyMedium: const TextStyle(fontSize: 16.0),
    titleMedium: const TextStyle(fontSize: 18.0),
    labelSmall: const TextStyle(fontSize: 16.0, letterSpacing: 1),
    bodyLarge: const TextStyle(),
    bodySmall: const TextStyle(),
  ),
  colorScheme: ColorScheme.fromSwatch().copyWith(secondary: mainColor),
);

final ThemeData darkTheme = ThemeData.dark().copyWith(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: darkBackgroundColor,
  primaryColor: darkMainColor,

  ///appBar theme
  appBarTheme: AppBarTheme(
    color: transparentColor,
    elevation: 0.0,
  ),

  ///text theme
  textTheme: GoogleFonts.openSansTextTheme().copyWith(
    titleSmall: TextStyle(color: disabledTextColor),
    labelLarge: TextStyle(color: disabledTextColor),
    bodyMedium: const TextStyle(fontSize: 16.0),
    titleMedium: const TextStyle(fontSize: 18.0),
    labelSmall: const TextStyle(fontSize: 16.0, letterSpacing: 1),
    bodyLarge: const TextStyle(),
    bodySmall: const TextStyle(),
  ),
  colorScheme: ColorScheme.fromSwatch().copyWith(secondary: darkMainColor),
);

extension AppTheme on ThemeData {
  Color get bottomBarColor {
    if (brightness == Brightness.light) {
      return secondaryColor;
    } else {
      return darkSecondaryColor;
    }
  }
}
