import 'package:redux/redux.dart';
import 'package:watertracker/actions/history_actions.dart';
import 'package:watertracker/actions/settings_actions.dart';
import 'package:watertracker/managers/database/database_manager.dart';
import 'package:watertracker/managers/database/drink_history.dart';
import 'package:watertracker/managers/settings/app_settings_manager.dart';
import 'package:watertracker/model/app_state.dart';

List<Middleware<AppState>> createStoreMiddleware() {
  final saveSettings = _createSaveSettings();
  final loadSettings = _createLoadSettings();
  final loadDrinksHistory = _createLoadDrinksHistory();
  final addDrinkToHistory = _createAddDrinkToHistory();
  final removeDrinkFromHistory = _createRemoveDrinkFromHistory();

  return [
    TypedMiddleware<AppState, LoadDrinkHistoryAction>(loadDrinksHistory),
    TypedMiddleware<AppState, LoadAppSettingsAction>(loadSettings),
    TypedMiddleware<AppState, SaveSettingsAction>(saveSettings),

    TypedMiddleware<AppState, AddDrinkToHistoryAction>(addDrinkToHistory),
    TypedMiddleware<AppState, RemoveDrinkFromHistoryAction>(
        removeDrinkFromHistory),
  ];
}

Middleware<AppState> _createSaveSettings() {
  return (Store<AppState> store, action, NextDispatcher next) {
    next(action);

    AppSettingsManager.saveSettings(store.state.settings.gender!,
        store.state.settings.age!, store.state.settings.dailyGoal!);
  };
}



Middleware<AppState> _createLoadSettings() {
  return (Store<AppState> store, action, NextDispatcher next) {
    AppSettingsManager.getSettings().then(
          (settings) {
        store.dispatch(
          AppSettingsLoadedAction(settings),
        );
      },
    );

    next(action);
  };
}

Middleware<AppState> _createLoadDrinksHistory() {
  return (Store<AppState> store, action, NextDispatcher next) {
    DatabaseManager.defaultManager
        .fetchAllEntriesOf(DrinkHistoryEntry)
        .then((maps) {
      List<DrinkHistoryEntry>? entries = [];
      var table = DrinkHistoryTable();
      maps.forEach((map) {
        DrinkHistoryEntry entry = table.entryFromMap(map);
        entries.add(entry);
      });
      store.dispatch(DrinkHistoryLoadedAction(entries));
    });

    next(action);
  };
}

Middleware<AppState> _createAddDrinkToHistory() {
  return (Store<AppState> store, action, NextDispatcher next) {
    DatabaseManager.defaultManager.insert([action.entry]);

    next(action);
  };
}

Middleware<AppState> _createRemoveDrinkFromHistory() {
  return (Store<AppState> store, action, NextDispatcher next) {
    DatabaseManager.defaultManager.remove([action.entry]);

    next(action);
  };
}
