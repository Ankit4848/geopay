import 'package:flutter/material.dart';

import 'theme_base.dart';

/// This is the class contains all the colors of the dark theme.
/// when user select the dark mode in the application then we use dark colors.
class DarkTheme extends ThemeBase {
  /// This is the constructor of the dark_theme to assign dark colors.
  /// all the colors for dark mode are defined in the constructor.
  DarkTheme()
      : super(
          blackColor: const Color(0xFF000000),
          whiteColor: const Color(0xFFFFFFFF),
          transparent: const Color(0x00000000),
          primaryColor: const Color(0xFF102030),
          redColor: const Color(0xFFFF0000),
          secondaryColor: const Color(0xFF81A8C7),
          lightGrey: const Color(0xFFF4F4F4),
          offBlueTextColor: const Color(0xFF7E99AF),
          darkGreyColor: const Color(0xFF181818),
          getStartedColor: const Color(0xFF2B4257),
          thirdColor: const Color(0xFF26425A),
          textFieldFilledColor: const Color(0xFFF5F4F4),
        );
}
