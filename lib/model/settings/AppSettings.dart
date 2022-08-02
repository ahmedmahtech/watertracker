import 'package:watertracker/screens/settings/Gender.dart';

class AppSettings {
  Gender? gender;
  int? age;
  int ?dailyGoal;



  AppSettings(
      {this.gender,
        this.age,
        this.dailyGoal,
});

  AppSettings copyWith(
      {Gender? gender,
        int ?age,
        int? dailyGoal}) {
    return AppSettings(
        gender: gender ?? this.gender,
        age: age ?? this.age,
        dailyGoal: dailyGoal ?? this.dailyGoal,
     );
  }
}
