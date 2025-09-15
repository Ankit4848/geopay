// ignore_for_file: avoid_print

import '../core.dart';

/// we are using "shared_preference" for storing data locally.
/// we also have to specify the key with the preference object.
/// this is the class which will manage all the key.
class LocalCacheKey {
  /// this is the key for application theme.
  static const String applicationThemeMode = 'provider_app_theme_mode';

  static const String isUserFirstTime = "isUserFirstTime";

  static const String token = "token";
}

class SharedPref {
  static Future<bool> isUserFirstTime() async {
    bool? isUserFirstTime =
        VariableUtilities.preferences.getBool(LocalCacheKey.isUserFirstTime);
    return isUserFirstTime ?? true;
  }

  static Future<void> setUserFirstTimeStatus() async {
    VariableUtilities.preferences.setBool(LocalCacheKey.isUserFirstTime, false);
  }

  static Future<void> setUserToken(String token) async {
    VariableUtilities.preferences
        .setString(LocalCacheKey.token, "Bearer $token");
  }

  static Future<String?> getUserToken() async {
    String token =
        VariableUtilities.preferences.getString(LocalCacheKey.token) ?? '';
    print("Token::: $token");
    return token;
  }
}
