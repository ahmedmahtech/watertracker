import 'package:watertracker/managers/database/drink_history.dart';
import 'package:watertracker/model/settings/AppSettings.dart';
import 'package:watertracker/model/water/Glass.dart';

class AppState {
  final AppSettings settings;
  final Glass glass;
  final List<DrinkHistoryEntry> drinksHistory;

  AppState({required this.settings,required this.glass,required this.drinksHistory});

  factory AppState.defaultState() {
    var settings = AppSettings(dailyGoal: 0);
    var glass = Glass(0, 0);
    return AppState(settings: settings, glass: glass, drinksHistory: []);
  }
}
