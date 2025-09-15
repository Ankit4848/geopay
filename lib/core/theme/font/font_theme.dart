import 'package:flutter/material.dart';

import '../../core.dart';

/// FontUtilities is main base class for all the styles of fonts used.
/// you can directly change the font styles in this file.
/// so, all the fonts used in application will be changed.
class FontUtilities {
  static TextStyle style({
    required double fontSize,
    Color? fontColor,
    FWT fontWeight = FWT.regular,
    TextDecoration? decoration,
    double letterSpacing = 0.5,
    FontFamily? fontFamily,
  }) {
    return TextStyle(
      color: fontColor ?? VariableUtilities.theme.primaryColor,
      fontWeight: getFontWeight(fontWeight),
      fontSize: fontSize,
      letterSpacing: letterSpacing,
      decoration: decoration,
      fontFamily: getFontFamily(fontFamily ?? FontFamily.poppins),
    );
  }
}

/// these are the most commonly used font weight for mobile application.
enum FWT {
  /// FontWeight -> 900
  black,

  /// FontWeight -> 800
  extraBold,

  /// FontWeight -> 700
  bold,

  /// FontWeight -> 600
  semiBold,

  /// FontWeight -> 500
  medium,

  /// FontWeight -> 400
  regular,

  /// FontWeight -> 300
  light,

  /// FontWeight -> 200
  extraLight,

  /// FontWeight -> 100
  thin,
}

/// THIS FUNCTION IS USED TO SET FONT WEIGHT ACCORDING TO SELECTED ENUM...
FontWeight getFontWeight(FWT fwt) {
  switch (fwt) {
    case FWT.thin:
      return FontWeight.w100;
    case FWT.extraLight:
      return FontWeight.w200;
    case FWT.light:
      return FontWeight.w300;
    case FWT.regular:
      return FontWeight.w400;
    case FWT.medium:
      return FontWeight.w500;
    case FWT.semiBold:
      return FontWeight.w600;
    case FWT.bold:
      return FontWeight.w700;
    case FWT.extraBold:
      return FontWeight.w800;
    case FWT.black:
      return FontWeight.w900;
  }
}

enum FontFamily { poppins, dmSans }

String getFontFamily(FontFamily fontFamlily) {
  switch (fontFamlily) {
    case FontFamily.poppins:
      return 'Poppins';
    case FontFamily.dmSans:
      return 'DMSans';
  }
}
