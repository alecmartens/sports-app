import 'package:flutter/material.dart';

final ThemeData appThemeData = ThemeData(
  // Styles for ElevatedButton
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: Colors.black,
      padding: const EdgeInsets.symmetric(vertical: 12.0),
    ),
  ),

  // Styles for TextButton (often used for links)
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: Colors.black,
    ),
  ),

  // Styles for Checkbox
  checkboxTheme: CheckboxThemeData(
    fillColor: MaterialStateProperty.resolveWith<Color>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.selected)) return Colors.black;
        return Colors.grey;
      },
    ),
  ),

  // Styles for OutlinedButton
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: Colors.black,
      side: BorderSide(color: Colors.black),
    ),
  ),

  iconTheme: const IconThemeData(
    color: Colors.black, // define the color for your   s
    size: 24.0, // define the default size
  ),
);
