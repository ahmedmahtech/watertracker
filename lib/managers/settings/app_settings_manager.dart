import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:watertracker/model/settings/AppSettings.dart';
import 'package:watertracker/screens/settings/Gender.dart';

class AppSettingsManager {
  static Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  static Future<AppSettings> getSettings() async {
    final SharedPreferences prefs = await _prefs;
    final genderInt = prefs.getInt(_AppSettingsKeys.gender) ?? -1;
    final gender = genderInt >= 0 ? Gender.values[genderInt] : null;
    final age = prefs.getInt(_AppSettingsKeys.age) ?? 0;
    final dailyGoal = prefs.getInt(_AppSettingsKeys.dailyGoal) ?? 0;



    return AppSettings(
        age: age,
        gender: gender,
        dailyGoal: dailyGoal
    );
  }

  static Future<bool> saveSettings(
      Gender gender, int age, int dailyGoal) async {
    final SharedPreferences prefs = await _prefs;

    prefs.setInt(_AppSettingsKeys.gender, gender != null ? gender.index : -1);
    prefs.setInt(_AppSettingsKeys.age, age != null ? age : 0);
    prefs.setInt(_AppSettingsKeys.dailyGoal, dailyGoal != null ? dailyGoal : 0);

    return true;
  }


}

class _AppSettingsKeys {
  static final gender = "gender";
  static final age = "age";
  static final dailyGoal = "dailyGoal";

}
