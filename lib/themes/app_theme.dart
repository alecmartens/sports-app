import 'package:flutter/material.dart';

// Define the colors
const primaryColor = Color(0xFF2E5AAC);
const secondaryColor = Color(0xFF6BC1E1);
const lightGreyText = Color(0xFFDDDDDD);
const darkGreyText = Color(0xFF333333);
const accentColor = Color(0xFFFF6B6B);
const errorColor = Color(0xFFD32F2F);
const successColor = Color(0xFF388E3C);
const softGreyBackground = Color(0xFFF4F4F4);
const darkBackground = Color(0xFF1E1E1E);

final ThemeData appThemeData = ThemeData(
  primaryColor: primaryColor,
  scaffoldBackgroundColor: softGreyBackground, 

  colorScheme: ColorScheme.light(
    primary: primaryColor,
    secondary: secondaryColor, // this replaces the old accentColor
    error: errorColor,
    background: softGreyBackground,
    onBackground: darkGreyText,
    surface: darkBackground,
    onSurface: lightGreyText,
  ),

  // Styles for ElevatedButton
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: primaryColor, // use primary color for elevated button
      padding: const EdgeInsets.symmetric(vertical: 12.0),
    ),
  ),

  // Styles for TextButton (often used for links)
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: secondaryColor, // use secondary color for text buttons
    ),
  ),

  // Styles for Checkbox
  checkboxTheme: CheckboxThemeData(
    fillColor: MaterialStateProperty.resolveWith<Color>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.selected)) return primaryColor;
        return Colors.grey;
      },
    ),
  ),

  // Styles for OutlinedButton
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: primaryColor,
      side: BorderSide(color: primaryColor),
    ),
  ),

  iconTheme: IconThemeData(
    color: primaryColor, // use primary color for icons
    size: 24.0,
  ),

  // Styles for TextField
  inputDecorationTheme: InputDecorationTheme(
    labelStyle: TextStyle(
      color: darkGreyText, // use dark gray for the label text in light theme
    ),
    border: OutlineInputBorder(
      borderSide: BorderSide(
          color: primaryColor), // use primary color for the default border
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
          color: primaryColor,
          width: 2.0), // use primary color for the focused border
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
          color: primaryColor,
          width: 1.0), // use primary color for the enabled border
    ),
  ),

  // Add text themes
  textTheme: TextTheme(
    bodyText1: TextStyle(color: lightGreyText), // for light theme
    bodyText2: TextStyle(color: darkGreyText), // for dark theme
  ),
);
