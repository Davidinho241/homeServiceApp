import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefKeys {
  SharedPrefKeys._();
  static const String darkModeEnabled = 'darkModeEnabled';
  static const String languageCode = 'languageCode';
  static const String currencyCode = 'currencyCode';
}

class SharedPreferencesService {
  static SharedPreferencesService _instance;
  static SharedPreferences _preferences;

  SharedPreferencesService._internal();

  static Future<SharedPreferencesService> get instance async {
    if (_instance == null) {
      _instance = SharedPreferencesService._internal();
    }

    if (_preferences == null) {
      _preferences = await SharedPreferences.getInstance();
    }

    return _instance;
  }

  Future<void> setDarkModeInfo(bool isDarkModeEnabled) async =>
      await _preferences.setBool(
          SharedPrefKeys.darkModeEnabled, isDarkModeEnabled);

  bool get isDarkModeEnabled =>
      _preferences.getBool(SharedPrefKeys.darkModeEnabled);

  Future<void> setLanguage(String langCode) async =>
      await _preferences.setString(SharedPrefKeys.languageCode, langCode);

  String get languageCode =>
      _preferences.getString(SharedPrefKeys.languageCode);

  Future<void> setCurrency(String currCode) async =>
      await _preferences.setString(SharedPrefKeys.currencyCode, currCode);

  String get currencyCode =>
      _preferences.getString(SharedPrefKeys.currencyCode) ?? "\$";
}
