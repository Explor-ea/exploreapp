import 'package:shared_preferences/shared_preferences.dart';

/// This class makes the `SharedPreferences` (local storage) available in the whole app,
/// and at anytime if `SharedPref.init()` is invoked in the `main()` function.
class SharedPref {
  static SharedPreferences? theSharedPreferences;
  static Future init() async {
    theSharedPreferences = await SharedPreferences.getInstance();
  }
}
