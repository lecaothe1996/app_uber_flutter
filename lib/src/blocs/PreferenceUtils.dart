import 'package:shared_preferences/shared_preferences.dart';

// remember password
class PreferenceUtils {
  static Future<SharedPreferences> get _instance async =>
      _prefsInstance ??= await SharedPreferences.getInstance();
  static SharedPreferences? _prefsInstance;

  static String keyIsLogin = "log_in";

  // call this method from iniState() function of mainApp().
  static Future<SharedPreferences?> init() async {
    _prefsInstance = await _instance;
    return _prefsInstance ?? await SharedPreferences.getInstance();
  }

  static String getString(String key, [String? defValue]) {
    return _prefsInstance?.getString(key) ?? defValue ?? "";
  }

  static Future<bool> setString(String key, String value) async {
    var prefs = await _instance;
    return prefs.setString(key, value);
  }

  static bool getBool(String key, [bool? defValue]) {
    return _prefsInstance?.getBool(key) ?? defValue ?? false;
  }

  static Future<bool> setBool(String key, bool value) async {
    var prefs = await _instance;
    return prefs.setBool(key, value);
  }

  static void clearData() {
    _prefsInstance?.clear();
  }
}
