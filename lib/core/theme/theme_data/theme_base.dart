import 'package:flutter/material.dart';

/// all the colores used in the application are managed using this theme_base.
/// if you want to use the additional colors then you can add in this class.
///
abstract class ThemeBase {
  /// Constructor of the theme_base to required all the colors.
  ThemeBase({
    required this.whiteColor,
    required this.blackColor,
    required this.transparent,
    required this.primaryColor,
    required this.redColor,
    required this.secondaryColor,
    required this.lightGrey,
    required this.offBlueTextColor,
    required this.darkGreyColor,
    required this.getStartedColor,
    required this.thirdColor,
    required this.textFieldFilledColor,
  });

  /// white color used in the application.
  final Color whiteColor;

  /// black color used in the application.
  final Color blackColor;

  /// transperent for application.
  final Color transparent;

  final Color primaryColor;

  final Color redColor;

  final Color secondaryColor;

  final Color lightGrey;

  final Color offBlueTextColor;

  final Color darkGreyColor;

  final Color getStartedColor;

  final Color thirdColor;

  final Color textFieldFilledColor;
}
